const mongoose = require('mongoose');
const dotenv= require('dotenv').config();
const connection = mongoose.connect(process.env.MONGODB_URI,{ useNewUrlParser: true, useUnifiedTopology: true });

connection.then(() => {
  if (mongoose.connection.readyState === 1) {
    console.log('DB connected');
  } else {
    console.log('DB not connected');
  }
});

module.exports = connection;
