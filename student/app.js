var mongoose = require("mongoose");
var express = require("express");
var app = express();
var bodyParser = require("body-parser");
var multer = require("multer");
var upload = multer();
const path = require("path");
const port = process.env.port || 3000;
var cors = require("cors");
app.use(cors());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
//app.use(upload.array());
app.use(express.static("upload"));
app.use(express.static(path.join(__dirname, "upload")));
app.use(express.static(path.join(__dirname, "public")));

app.engine("html", require("ejs").renderFile);
app.set("view engine", "html");
app.set("views", "views");

const clientController = require("./controller/clientController");

app.use("/student", clientController);

app.use((error, req, res, next) => {
  console.log(error);
  const status = error.statusCode || 500;
  const message = error.message;
  const data = error.data;
  res.status(status).json({ message: message, data: data });
});

mongoose
  .connect("mongodb://localhost:27017/studentTBL", {
    useUnifiedTopology: true,
    useNewUrlParser: true,
  })
  .then((result) => {
    console.log("Database Connect");
    app.listen(port, () => {
      console.log("server listening on port " + port);
    });
  })
  .catch((err) => {
    console.log(err);
  });
