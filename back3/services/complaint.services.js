const Complaintmodel = require('../model/complaint.model');
const complaintmodel = require('../model/complaint.model');
const { sendNotificationEmail } = require('../emailNotifications');
const cloudinary = require('cloudinary');
const fs = require('fs');

class complaintservices {
  static async create(title, type, description, submitter, comments, location, status, file, date) {
    try {
      let fileUrl = '';
    
      if (file) {
        const uploadRes = await cloudinary.uploader.upload('temp/'+file.filename).then((res)=>{
          fileUrl = res.secure_url;
          const filePath = 'temp/'+file.filename ;

fs.unlink(filePath, (err) => {
  if (err) {
    console.error('Error deleting file:', err);
  }
});
        }).catch((err)=>{
          console.log(err);

        })
      }
  
      const complaint = new complaintmodel({ title, type, description, submitter, comments, location, status, file: fileUrl, date });
      return await complaint.save();
    } catch (error) {
      throw error;
    }
  }
  
  




  static async delete(complaintId) {

      const deleted = await complaintmodel.findOneAndDelete({_id:complaintId});
      return deleted;

  
  }
    static async getcomplaintdata(submitter) {
    
//
      const complaintdata = await Complaintmodel.find({submitter}).populate({
          path: 'comments',
          populate: {
            path: 'submitter',
            select: 'firstName lastName',
          },
        })
        .populate('submitter', 'firstName lastName');
      
      return complaintdata;

    
  }


  static async enTendence() {
    try {
      const complaints = await Complaintmodel.aggregate([
        // unwind the comments array to create a separate document for each comment
        { $unwind: '$comments' },
        // group the documents by complaint ID and count the number of comments for each group
        { $group: { _id: '$_id', commentCount: { $sum: 1 } } },
        // sort the groups by commentCount in descending order
        { $sort: { commentCount: -1 } },
        // limit the output to the top 10 groups
        { $limit: 10 },
        // look up the complaint documents by their IDs and include the commentCount field
        {
          $lookup: {
            from: 'complaints',
            localField: '_id',
            foreignField: '_id',
            as: 'complaints',
          },
        },
        { $unwind: '$complaints' },
        // project the desired fields for the output
        {
          $project: {
            _id: '$complaints._id',
            title: '$complaints.title',
            type: '$complaints.type',
            description: '$complaints.description',
            submitter: '$complaints.submitter',
            comments: '$complaints.comments',
            location: '$complaints.location',
            status: '$complaints.status',
            file: '$complaints.file',
            date: '$complaints.date',
            commentCount: 1,
          },
        },
        // look up the user documents by their _id field
        {
          $lookup: {
            from: 'users',
            localField: 'submitter',
            foreignField: '_id',
            as: 'submitter',
          },
        },
        { $unwind: '$submitter' },
        // project the firstName and lastName properties from the submitter user
        {
          $lookup: {
            from: 'users',
            localField: 'comments.submitter',
            foreignField: '_id',
            as: 'commentSubmitters'
          }
        },
        {
          $project: {
            _id: 1,
            title: 1,
            type: 1,
            description: 1,
            submitter: {
              _id: '$submitter._id',
              firstName: '$submitter.firstName',
              lastName: '$submitter.lastName'
            },
            comments: {
              $map: {
                input: '$comments',
                as: 'comment',
                in: {
                  _id: '$$comment._id',
                  comment: '$$comment.comment',
                  submitter: {
                    $let: {
                      vars: {
                        commentSubmitter: {
                          $arrayElemAt: [
                            {
                              $filter: {
                                input: '$commentSubmitters',
                                cond: { $eq: ['$$this._id', '$$comment.submitter'] }
                              }
                            },
                            0
                          ]
                        }
                      },
                      in: {
                        _id: '$$commentSubmitter._id',
                        firstName: '$$commentSubmitter.firstName',
                        lastName: '$$commentSubmitter.lastName'
                      }
                    }
                  }
                }
              }
            },
            location: 1,
            status: 1,
            file: 1,
            date: 1,
            commentCount: 1
          }
        },
        
      ]);
  
      return complaints;
    } catch (error) {
      throw error;
    }
  }
  
    
  

  static async addComment(complaintId, comment, submitter) {
    try {
      const updatedComplaint = await Complaintmodel.findOneAndUpdate(
        { _id: complaintId },
        { $push: { comments: { comment, submitter } } },
        { new: true }
      )
        .populate('comments.submitter', 'firstName lastName')
        //.populate('submitter', 'email')
        .exec();
       //

      return updatedComplaint;
    } catch (error) {
      throw error;
    }
  }
  

  static async unComment(complaintId, commentId) {
    try {
      const updatedComplaint = await Complaintmodel.findOneAndUpdate(
        { _id: complaintId },
        { $pull: { comments: { _id: commentId } } },
        { new: true }
      ).populate('comments.submitter', 'firstName lastName')
      .exec();
      return updatedComplaint;
    } catch (error) {
      throw error;
    }
  }

  
  static async adminRes(complaintId, response) {
    try {
      const complaint = await Complaintmodel.findOneAndUpdate(
        { _id: complaintId },
        { $set: { adminresponse: response } }, // Use $set instead of $push
        { new: true }
      ).populate('submitter', 'email')
      .exec();
      const subject = 'reclamation mise a jour'; 
      const body = 'Votre reclamation a été mise à jour. Veuillez vérifier la réponse'; 
      await sendNotificationEmail(complaint.submitter.email, subject, body);
      return complaint;
    } catch (error) {
      throw error;
    }
  }
  


 static async  updateComplaintStatus(complaintId, status) {
    try {
      const complaint = await complaintmodel.findByIdAndUpdate(
        complaintId,
        { status },
        { new: true }
      ) .populate('submitter', 'email')
      .exec();
      const subject = 'Mise à jour de l etat de reclamation'; 
      const body = 'L etat de votre reclamation a été mis à jour. Veuillez vérifier le nouveau statut.'; 
      await sendNotificationEmail(complaint.submitter.email, subject, body);
      if (!complaint) {
        throw new Error('Complaint not found');
      }
      
  
      return complaint;
    } catch (error) {
      throw error;
    }
  }

  static async AllComplaints(filterType) {
    try {
      let query = {};
  
      // If a filterType is provided, include it in the query
      if (filterType) {
        query['type.type'] = filterType;
      }
  
      const complaints = await Complaintmodel.find(query)
        .populate({
          path: 'comments',
          populate: {
            path: 'submitter',
            select: 'firstName lastName',
          },
        })
        .populate('submitter', 'firstName lastName');
  
      return complaints;
    } catch (error) {
      throw error;
    }
  }

  static async AllComplaintss() {
    try {
      const complaints = await Complaintmodel.find()
  
      return complaints;
    } catch (error) {
      throw error;
    }
  }
  
  
  
    

  static async pending() {
    try {
      const complaints = await complaintmodel.find({ status: 'pending' }).exec();
      return complaints;
    } catch (error) {
      console.error('Error retrieving pending complaints:', error);
      throw error;
    }
  }

  static async resolved() {
    try {
      const complaints = await complaintmodel.find({ status: 'resolved' }).exec();
      return complaints;
    } catch (error) {
      console.error('Error retrieving resolved complaints:', error);
      throw error;
    }
  }

  static async inProgress() {
    try {
      const complaints = await complaintmodel.find({ status: 'inProgress' }).exec();
      return complaints;
    } catch (error) {
      console.error('Error retrieving inProgress complaints:', error);
      throw error;
    }
  }

  static async education() {
    try {
      const complaints = await Complaintmodel.find({ 'type.type': 'education' }).exec();
      return complaints;
    } catch (error) {
      console.error('Error retrieving education complaints:', error);
      throw error;
    }
  
  }
  static async water() {
    try {
      const complaints = await Complaintmodel.find({ 'type.type': 'water' }).exec();
      return complaints;
    } catch (error) {
      console.error('Error retrieving education complaints:', error);
      throw error;
    }
  
  }
  static async electricity() {
    try {
      const complaints = await Complaintmodel.find({ 'type.type': 'electricity' }).exec();
      return complaints;
    } catch (error) {
      console.error('Error retrieving education complaints:', error);
      throw error;
    }
  
  }
  static async envi() {
    try {
      const complaints = await Complaintmodel.find({ 'type.type': 'environement' }).exec();
      return complaints;
    } catch (error) {
      console.error('Error retrieving education complaints:', error);
      throw error;
    }
  
  }
  static async transport() {
    try {
      const complaints = await Complaintmodel.find({ 'type.type': 'transport' }).exec();
      return complaints;
    } catch (error) {
      console.error('Error retrieving education complaints:', error);
      throw error;
    }
  
  }
  static async consumer() {
    try {
      const complaints = await Complaintmodel.find({ 'type.type': 'consumer affer' }).exec();
      return complaints;
    } catch (error) {
      console.error('Error retrieving education complaints:', error);
      throw error;
    }
  
  }
  static async medical() {
    try {
      const complaints = await Complaintmodel.find({ 'type.type': 'medical' }).exec();
      return complaints;
    } catch (error) {
      console.error('Error retrieving education complaints:', error);
      throw error;
    }
  
  }
  static async autre() {
    try {
      const complaints = await Complaintmodel.find({ 'type.type': 'autre' }).exec();
      return complaints;
    } catch (error) {
      console.error('Error retrieving education complaints:', error);
      throw error;
    }
  
  }
  
  
  
  
  
  
  
  
  
  static async getComplaintCountsByType(type) {
    try {
      const complaintCounts = await complaintmodel.aggregate([
        { $match: { 'type.type': type } },
        { $group: { _id: '$type.type', count: { $sum: 1 } } }
      ]).exec();
  
      if (complaintCounts.length === 0) {
        return 0; // Return 0 if no complaints found for the given type
      }
  
      return complaintCounts[0].count;
    } catch (error) {
      console.error('Error retrieving complaint count by type:', error);
      throw error;
    }
  }

}

module.exports = complaintservices;
