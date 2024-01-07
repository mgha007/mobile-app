const mongoose = require('mongoose');
const db = require('../config/db');
const { ObjectId } = mongoose.Schema.Types;
const typeSchema = new mongoose.Schema({
  type: String,
  soustype: String
});

const complaintSchema = new mongoose.Schema({
  title: {
    type: String,
    required: false
  },
  type: {
    type: typeSchema,
    required: false
  },
  description: {
    type: String,
    required: false
  },
  submitter: {
    type: mongoose.Schema.Types.ObjectId, // store the user ID as an object ID reference
    ref: 'User', // specify the referenced model (assuming it's called User)
    required: false
  },
  comments: {
    type: [{
      comment:String,
      submitter:{type:ObjectId,ref:"User"},
      
    }]
  },
  location: {
    type: {
      address: String,
      latitude: Number,
      longitude: Number
    },
    required: false
  },
  status: {
    type: String,
    enum: ['pending', 'inProgress', 'resolved'],
    default: 'pending'
  },
  adminresponse:{
    type:String
  },
  file: {
    type: Object
  },
  date: {
    type: Date,
    default: Date.now // set the default value to the current date and time
  }
});


const Complaintmodel = mongoose.model('Complaint', complaintSchema);

module.exports = Complaintmodel;
