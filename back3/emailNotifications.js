const nodemailer = require('nodemailer');

async function sendNotificationEmail(recipientEmail, subject, body) {
  try {
    const transporter = nodemailer.createTransport({
      service: 'gmail',
      port: 587,
      secure: false,
      auth: {
        user:"complaintapp3@gmail.com",
        pass: "nyhjswihrybxbyhg",
      },
    });

    const mailOptions = {
      from: "complaintapp3@gmail.com",
      to: recipientEmail,
      subject: subject,
      text: body,
    };

    const info = await transporter.sendMail(mailOptions);
    console.log('Notification email sent:', info.messageId);
  } catch (error) {
    console.error('Error sending notification email:', error);
  }
}

module.exports = { sendNotificationEmail };
