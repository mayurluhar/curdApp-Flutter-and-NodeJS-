var mongoose = require("mongoose");
const { boolean } = require("webidl-conversions");

studentSchema = mongoose.Schema({
  rollNo: {
    type: String,
  },
  studentName: {
    type: String,
  },
  password: {
    type: String,
  },
  studentImage: {
    type: String,
  },
  studentDOB: {
    type: String,
  },
  contactNo: {
    type: String,
  },
  gender: {
    type: String,
  },
  email: {
    type: String,
  },
  language: {
    type: String,
  },
  course: {
    type: String,
  },
  addedOn: {
    type: Date,
  },
  isActive: {
    type: Boolean,
  },
});

module.exports = mongoose.model("students", studentSchema);
