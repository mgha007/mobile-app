const usermodel = require ('../model/user.model');
const nodemailer = require('nodemailer');
const jwt = require('jsonwebtoken')
class userservice {
    static async signupuser (firstName,lastName,email,mobileNumber,password){
        try {
            const createuser = new usermodel({firstName,lastName,email,mobileNumber,password});
            return await createuser.save();
        } catch (error) {
            throw error;
            
        }

    }


    static async getinfo(userId) {
      try {
        const user = await usermodel.findById(userId);
        if (!user) {
          throw new Error('User not found');
        }
        return user;
      } catch (error) {
        throw error;
      }
    }


    static async checkUser(email){
        try {
            return await usermodel.findOne({email});
        } catch (error) {
            throw error;
        }
    }

    

    static async generateAccessToken(tokenData,JWTSecret_Key,JWT_EXPIRE){
        return jwt.sign(tokenData, JWTSecret_Key, { expiresIn: JWT_EXPIRE });
    }

    static async banUser(userId, durationInDays) {
      try {
        const user = await usermodel.findById(userId);
        if (!user) {
          throw new Error('User not found');
        }
    
        let bannedUntil = null;
        const currentDate = new Date(); // Declare and initialize currentDate variable
        if (durationInDays === 'forever') {
          user.isBanned = true;
        } else {
          const durationInMilliseconds = durationInDays * 24 * 60 * 60 * 1000;
          bannedUntil = new Date(currentDate.getTime() + durationInMilliseconds);
          user.isBanned = true;
          user.bannedUntil = bannedUntil;
        }
    
        const updatedUser = await user.save();
    
        // Schedule the automatic ban lifting
        if (durationInDays !== 'forever') {
          const banDuration = bannedUntil - currentDate;
          setTimeout(async () => {
            await usermodel.findByIdAndUpdate(
              userId,
              { isBanned: false, bannedUntil: null },
              { new: true }
            );
            // Additional logic can be added here, such as sending notifications
          }, banDuration);
        }
    
        return updatedUser;
      } catch (error) {
        throw error;
      }
    }

    static async grantadmin(userId) {
      try {
        const user = await usermodel.findById(userId);
        if (!user) {
          throw new Error('User not found');
        }
    
        user.isAdmin = true;
    
        const updatedUser = await user.save();
        return updatedUser;
      } catch (error) {
        throw error;
      }
    }
    
        static async forgotPassword(email){
          try {
            const user = await usermodel.findOne({ email });
        
            if (!user) {
              throw new Error('User not found');
            }
        
            const resetCode = await user.generateResetCode();
        
            // Send the reset password email
            const transporter = nodemailer.createTransport({
              service: 'gmail',
              auth: {
                user: config.mailer.email,
                pass: config.mailer.password,
              },
            });
        
            await transporter.sendMail({
              to: user.email,
              from: config.mailer.email,
              subject: 'Password Reset',
              text: `Your password reset code is: ${resetCode}`,
            });
          } catch (error) {
            throw error;
          }

        }
        static async resetPassword(email,resetCode, newPassword){
          try {
            const user = await usermodel.findOne({
              email,
              resetToken: resetCode,
              resetTokenExpiration: { $gt: Date.now() },
            });
        
            if (!user) {
              throw new Error('Invalid or expired code');
            }
        
            // Hash the new password
            const hashedPassword = await bcrypt.hash(newPassword, 10);
            user.password = hashedPassword;
            user.resetToken = undefined;
            user.resetTokenExpiration = undefined;
            await user.save();
          } catch (error) {
            throw error;
          }
        }

        
    

}

module.exports =userservice;