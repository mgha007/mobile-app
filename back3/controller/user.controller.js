const userservice = require('../services/user.services');
 exports.signup= async(req,res,next)=>{
    try {
        const{firstName,lastName,email,mobileNumber,password}=req.body;

        const successres = await userservice.signupuser(firstName,lastName,email,mobileNumber,password);
        res.json({status :true,success :"signup successful"})
        
    } catch (error) {
        throw error;
            
        
    }
 }

 exports.login = async (req, res, next) => {
    try {
        const { email, password } = req.body;
        if (!email || !password) {
            throw new Error('Parameter are not correct');
        }
        let user = await userservice.checkUser(email);
        if (!user) {
            throw new Error('User does not exist');
        }
        const isPasswordCorrect = await user.comparePassword(password);
        if (isPasswordCorrect === false) {
            throw new Error(`Username or Password does not match`);
        }
        // Creating Token
        let tokenData;
        tokenData = { _id: user._id, email: user.email ,isAdmin:user.isAdmin,isBanned:user.isBanned};
    
        const token = await userservice.generateAccessToken(tokenData,"secret","1h")
        res.status(200).json({ status: true, success: "sendData", token: token });
    } catch (error) {
        console.log(error, 'err---->');
        next(error);
    }
}

exports.getinfo = async (req, res, next) => {
  try {
    const { userId } = req.body;
    const user = await userservice.getinfo(userId);
    res.json({ status: true, success: user || 'User not found' });
  } catch (error) {
    throw error;
  }
};


exports.banUser = async (req, res, next) => {
    const { userId, durationInDays } = req.body;
    try {
      const updatedUser = await userservice.banUser(userId, durationInDays);
      res.json({ status: true, success: updatedUser });
    } catch (error) {
      next(error);
    }
}

exports.grantadmin = async (req, res, next) => {
  const { userId } = req.body;
  try {
    const updatedUser = await userservice.grantadmin(userId);
    res.json({ status: true, success: updatedUser });
  } catch (error) {
    next(error);
  }
}
exports.forgotPassword = async (req, res) => {
    const { email } = req.body;
  
    try {
      await userservice.forgotPassword(email);
      res.json({ message: 'Password reset code sent' });
    } catch (error) {
      console.error(error);
      res.status(500).json({ message: 'Server error' });
    }
  };
  exports.resetPassword = async (req, res) => {
    const { email, resetCode, newPassword } = req.body;
  
    try {
      await userservice.resetPassword(email, resetCode, newPassword);
      res.json({ message: 'Password reset successfully' });
    } catch (error) {
      console.error(error);
      res.status(500).json({ message: 'Server error' });
    }
  };