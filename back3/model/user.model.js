const mongoose = require('mongoose');
const bcrypt = require('bcrypt');

const userSchema = new mongoose.Schema({
  firstName: {
    type: String,
    required: true
  },
  lastName: {
    type: String,
    required: true
  },
  email: {
    type: String,
    required: true,
    unique: true
  },
  mobileNumber: {
    type: String,
    required: true
  },
  password: {
    type: String,
    required: true
  },
  photo: {
    type: String,
    default: null
  },
  isBanned: {
    type: Boolean,
    default: false
  },
  isAdmin: {
    type: Boolean,
    default: false
  },
  resetToken: String,
  resetTokenExpiration: Date
});

userSchema.pre('save', async function () {
  try {
    const user = this;
    if (!user.isModified('password')) return;

    const salt = await bcrypt.genSalt(10);
    const hash = await bcrypt.hash(user.password, salt);
    user.password = hash;
  } catch (error) {
    throw error;
  }
});

userSchema.methods.comparePassword = async function (candidatePassword) {
  try {
    const isMatch = await bcrypt.compare(candidatePassword, this.password);
    return isMatch;
  } catch (error) {
    throw error;
  }
};

userSchema.methods.generateResetCode = async function () {
  try {
    const user = this;
    const resetCode = Math.floor(100000 + Math.random() * 900000).toString(); // Generate a random 6-digit code
    const resetTokenExpiration = Date.now() + 3600000; // Code expires in 1 hour

    user.resetToken = resetCode;
    user.resetTokenExpiration = resetTokenExpiration;
    await user.save();

    return resetCode;
  } catch (error) {
    throw error;
  }
};

const User = mongoose.model('User', userSchema);

module.exports = User;
