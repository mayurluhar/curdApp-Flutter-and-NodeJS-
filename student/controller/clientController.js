var express = require("express");
var router = express.Router();
var multer = require("multer");
const { v4: uuidv4 } = require("uuid");
var path = require("path");
const StudentModel = require("../models/studentModel");

function random(min, max) {
  return Math.floor(Math.random() * (max - min) + min);
}

var storage = multer.diskStorage({
  destination: function (req, res, cb) {
    cb(null, "./public/upload/image/");
  },
  filename: function (req, file, cb) {
    console.log("FileName : " + file.originalname);
    var extension = path.extname(file.originalname);
    cb(null, "IMG_" + random(1, 999) + extension);
  },
});

const fileFilter = (req, file, cb) => {
  if (
    file.mimetype === "image/jpeg" ||
    file.mimetype === "image/jpg" ||
    file.mimetype === "image/png"
  ) {
    cb(null, true);
  } else {
    cb(null, false);
  }
};

var upload = multer({
  storage: storage,
  fileFilter: fileFilter,
});

router.post("/register", async (req, res) => {
  var studentModel = new StudentModel();
  studentModel.rollNo = req.body.rollNo;
  studentModel.studentName = req.body.studentName;
  studentModel.password = req.body.password;
  studentModel.email = req.body.email;
  studentModel.studentImage = "";
  studentModel.studentDOB = req.body.studentDOB;
  studentModel.contactNo = req.body.contactNo;
  studentModel.gender = req.body.gender;
  studentModel.language = req.body.language;
  studentModel.course = req.body.course;
  studentModel.addedOn = new Date();
  studentModel.isActive = true;

  var inserted = await studentModel.save();

  if (inserted != null) {
    res.json({ result: "success", msg: "Student Inserted", data: 1 });
  } else {
    res.json({ result: "failure", msg: "Student Not Inserted", data: 0 });
  }
});

router.post("/updateStudent", async (req, res) => {
  var updated = await StudentModel.updateOne(
    { _id: req.body.id },
    {
      rollNo: req.body.rollNo,
      studentName: req.body.studentName,
      studentDOB: req.body.studentDOB,
      contactNo: req.body.contactNo,
      gender: req.body.gender,
      language: req.body.language,
      course: req.body.course,
    }
  );

  if (updated != null) {
    res.json({ result: "success", msg: "Student Updated", data: 1 });
  } else {
    res.json({ result: "failure", msg: "Student Not Updated", data: 0 });
  }
});

router.post("/getStudent", async (req, res) => {
  const objStudent = await StudentModel.findOne({ _id: req.body.id });
  console.log(objStudent);
  if (objStudent != null) {
    res.json({ result: "success", msg: "Student Found", data: objStudent });
  } else {
    res.json({ result: "failure", msg: "Student Not Found", data: objStudent });
  }
});

router.post("/login", async (req, res) => {
  var email = req.body.email;
  var password = req.body.password;
  console.log("Email:" + email);
  console.log("password:" + password);
  const objStudent = await StudentModel.findOne({
    email: email,
    password: password,
  });

  if (objStudent != null) {
    res.json({ result: "success", msg: "Student Found", data: objStudent });
  } else {
    res.json({ result: "failure", msg: "Student Not Found", data: objStudent });
  }
});

router.post(
  "/updateStudentPhoto",
  upload.single("studentImage"),
  async (req, res) => {
    console.log("File");
    console.log(req);
    const objStudent = await StudentModel.updateOne(
      {
        _id: req.body.id,
      },
      {
        studentImage: req.file.filename,
      }
    );
    if (objStudent != null) {
      res.json({
        result: "success",
        msg: "Student Photo Updated",
        data: 1,
      });
    } else {
      res.json({
        result: "failure",
        msg: "Student Photo Not Updated",
        data: 0,
      });
    }
  }
);

router.get("/getStudentList", async (req, res) => {
  const objStudent = await StudentModel.find();

  if (objStudent != null) {
    res.json({
      result: "success",
      msg: "Student List Found",
      data: objStudent,
    });
  } else {
    res.json({
      result: "failure",
      msg: "Student List Not Found",
      data: objStudent,
    });
  }
});

module.exports = router;
