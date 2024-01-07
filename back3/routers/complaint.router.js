const router = require('express').Router();
const complaintcontroller = require('../controller/complaint.controller');
const multer = require('multer');

// Configure multer storage
const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, 'temp/'); // Specify the temporary directory path
  },
  filename: function (req, file, cb) {

    let filename= Date.now() + '-' + file.originalname
    cb(null,filename); // Generate a unique filename
  }
});

// Create multer upload middleware
const upload = multer({ storage: storage });

router.post('/create', upload.single('file'), complaintcontroller.create);
router.delete('/delete', complaintcontroller.delete);
router.post('/complaintUser', complaintcontroller.complaintUser);
router.get('/enTendence', complaintcontroller.enTendence);
router.get('/pending', complaintcontroller.pending);
router.get('/resolved', complaintcontroller.resolved);
router.get('/inProgress', complaintcontroller.inProgress);
router.get('/education', complaintcontroller.education);
router.get('/water', complaintcontroller.water);
router.get('/electricity', complaintcontroller.electricity);
router.get('/consumer', complaintcontroller.consumer);
router.get('/envi', complaintcontroller.envi);
router.get('/transport', complaintcontroller.transport);
router.get('/medical', complaintcontroller.medical);
router.get('/autre', complaintcontroller.autre);
router.get('/getComplaintCountsByType', complaintcontroller.getComplaintCountsByType);
router.post('/AllComplaints', complaintcontroller.AllComplaints);
router.get('/AllComplaintss', complaintcontroller.AllComplaintss);
router.put('/addComment', complaintcontroller.addComment);
router.put('/unComment', complaintcontroller.unComment);
router.put('/res', complaintcontroller.adminRes);
router.put('/updateComplaintS', complaintcontroller.updateComplaintStatus);

module.exports = router;
