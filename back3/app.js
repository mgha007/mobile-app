const express = require ('express');
const db = require('./config/db');
const body_parser= require('body-parser');
const userrouter = require('./routers/user.router');
const complaintrouter = require('./routers/complaint.router');
const dotenv= require('dotenv').config();
const app= express(); 
app.use(express.json())
app.use(body_parser.json());
app.use(body_parser.urlencoded({ extended: true }));
app.use('/',userrouter);
app.use('/',complaintrouter);
module.exports =app;