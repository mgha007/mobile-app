const complaintservices = require('../services/complaint.services');
const multer = require('multer');

// Configure multer storage

exports.create = async (req, res, next,) => {
  try {
    const { title, description, submitter, comments, status, date } = req.body;    
    const file = req.file;
    location=JSON.parse(req.body.location);
    type=JSON.parse(req.body.type);


    const complaint = await complaintservices.create(title, type, description, submitter, comments, location, status, file, date);
    
    res.json({ status: true, success: complaint });
  } catch (error) {
    throw error;
  }
};


exports.delete = async (req, res, next) => {


  try {
    const { complaintId} = req.body;
    const deleted = await complaintservices.delete(complaintId);
        res.json({ status: true, success: deleted });
   
    
  } catch (error) {
    throw(error);
  }
};

exports.complaintUser = async (req, res, next) => {


  try {
    const { submitter } = req.body;
    const complaints = await complaintservices.getcomplaintdata(submitter);
    
        res.json({ status: true, success: complaints });
   
    
  } catch (error) {
    throw(error);
  }
};

exports.enTendence= async (req, res, next) =>{
  try {
    const complaints = await complaintservices.enTendence();
    res.status(200).json({ status: true, success: complaints });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
}

exports.addComment = async (req, res, next) => {

  const { complaintId,comment, submitter } = req.body;
  try {
    const updatedComplaint = await complaintservices.addComment(complaintId, comment, submitter);
    res.json({ status: true, success: updatedComplaint });
  } catch (error) {
    next(error);
  }
};

exports.unComment = async (req, res, next) => {
  const { complaintId, commentId } = req.body;
  try {
    const updatedComplaint = await complaintservices.unComment(complaintId, commentId);
    res.json({ status: true, success: updatedComplaint });
  } catch (error) {
    next(error);
  }
};
exports.adminRes = async (req, res, next) => {

  const { complaintId,response } = req.body;
  try {
    const updatedComplaint = await complaintservices.adminRes(complaintId, response);
    res.json({ status: true, success: updatedComplaint });
  } catch (error) {
    next(error);
  }
};

exports.updateComplaintStatus = async (req, res, next) => {
  const { complaintId, status } = req.body;

  try {
    const updatedComplaint = await complaintservices.updateComplaintStatus(
      complaintId,
      status
    );

    res.json({ status: true, success: updatedComplaint });
  } catch (error) {
    next(error);
  }
};


exports.AllComplaints = async (req, res, next) => {
  const {filterType}=req.body
  try {
     // Retrieve the 'type' parameter from the query string
    const complaints = await complaintservices.AllComplaints(filterType);
    res.status(200).json({ status: true, success: complaints });
  } catch (error) {
    console.error('Error getting complaints:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
};

exports.AllComplaintss = async (req, res, next) => {
  
  try {
     // Retrieve the 'type' parameter from the query string
    const complaints = await complaintservices.AllComplaintss();
    res.status(200).json({ status: true, success: complaints });
  } catch (error) {
    console.error('Error getting complaints:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
};

exports.pending = async (req, res, next) => {
  
  try {
     // Retrieve the 'type' parameter from the query string
    const complaints = await complaintservices.pending();
    res.status(200).json({ status: true, success: complaints });
  } catch (error) {
    console.error('Error getting complaints:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
};

exports.resolved = async (req, res, next) => {
  
  try {
     // Retrieve the 'type' parameter from the query string
    const complaints = await complaintservices.resolved();
    res.status(200).json({ status: true, success: complaints });
  } catch (error) {
    console.error('Error getting complaints:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
};

exports.inProgress = async (req, res, next) => {
  
  try {
     // Retrieve the 'type' parameter from the query string
    const complaints = await complaintservices.inProgress();
    res.status(200).json({ status: true, success: complaints });
  } catch (error) {
    console.error('Error getting complaints:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
};

exports.education = async (req, res, next) => {
  
  try {
     // Retrieve the 'type' parameter from the query string
    const complaints = await complaintservices.education();
    res.status(200).json({ status: true, success: complaints });
  } catch (error) {
    console.error('Error getting complaints:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
};

exports.water = async (req, res, next) => {
  
  try {
     // Retrieve the 'type' parameter from the query string
    const complaints = await complaintservices.water();
    res.status(200).json({ status: true, success: complaints });
  } catch (error) {
    console.error('Error getting complaints:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
};
exports.electricity = async (req, res, next) => {
  
  try {
     // Retrieve the 'type' parameter from the query string
    const complaints = await complaintservices.electricity();
    res.status(200).json({ status: true, success: complaints });
  } catch (error) {
    console.error('Error getting complaints:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
};
exports.envi = async (req, res, next) => {
  
  try {
     // Retrieve the 'type' parameter from the query string
    const complaints = await complaintservices.envi();
    res.status(200).json({ status: true, success: complaints });
  } catch (error) {
    console.error('Error getting complaints:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
};
exports.transport = async (req, res, next) => {
  
  try {
     // Retrieve the 'type' parameter from the query string
    const complaints = await complaintservices.transport();
    res.status(200).json({ status: true, success: complaints });
  } catch (error) {
    console.error('Error getting complaints:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
};
exports.consumer = async (req, res, next) => {
  
  try {
     // Retrieve the 'type' parameter from the query string
    const complaints = await complaintservices.consumer();
    res.status(200).json({ status: true, success: complaints });
  } catch (error) {
    console.error('Error getting complaints:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
};
exports.autre = async (req, res, next) => {
  
  try {
     // Retrieve the 'type' parameter from the query string
    const complaints = await complaintservices.autre();
    res.status(200).json({ status: true, success: complaints });
  } catch (error) {
    console.error('Error getting complaints:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
};

exports.medical = async (req, res, next) => {
  
  try {
     // Retrieve the 'type' parameter from the query string
    const complaints = await complaintservices.medical();
    res.status(200).json({ status: true, success: complaints });
  } catch (error) {
    console.error('Error getting complaints:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
};




exports.getComplaintCountsByType = async (req, res, next) => {
  
  try {
    const { type } = req.body;
    const count = await complaintservices.getComplaintCountsByType(type);
    res.json({ count });
  } catch (error) {
    console.error('Error:', error);
    res.status(500).json({ error: 'Failed to retrieve complaint count by type' });
  }
};


