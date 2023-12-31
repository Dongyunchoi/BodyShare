const dotenv = require("dotenv");

// 기본 .env 파일 로딩
dotenv.config({ path: ".env" });
// 환경별 .env 파일 로딩
console.log("NODE_ENV", process.env.NODE_ENV);
if (process.env.NODE_ENV) {
  dotenv.config({ override: true, path: `.env.${process.env.NODE_ENV}` });
}

var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');
const cors = require("cors");
const session = require("express-session");

var indexRouter = require('./routes/index');

var app = express();

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use("/images", express.static(path.join(__dirname, 'public/images')));
app.use(express.static(path.join(__dirname, "..", "BodyShare-app", "build")));

app.use(session({
  cookie: { maxAge: 1000 * 60 * 60 * 1 },   // 로그인 유지 시간
  secret: 'your-secret-key',
  rolling: true,        // 매 응답마다 쿠키 시간 초기화
  resave: false,        // 세션값이 수정되지 않으면 서버에 다시 저장하지 않음
  saveUninitialized: true,  //세션에 값이 없으면 쿠키를 전송하지 않음
}));            // req.session 속성을 만들어서 세션 객체를 저장

app.use(cors({
  origin: /^http:\/\/localhost/,
  credentials: true
}));
app.use('/api', indexRouter);

// 404 에러 처리
app.use('/api', (req, res, next) => {
  console.error(404, req.url);
  res.json({ error: { message: "존재하지 않는 API입니다." } });
});

// React용 fallback 추가
app.use("/", (req, res, next) => {
  res.sendFile(path.join(__dirname, "..", "BodyShare-app", "build", "index.html"));
});

// 500 에러 처리
app.use((err, req, res, next) => {
  console.error(err.stack);
  console.error(err.cause);
  res.json({ error: { message: "요청을 처리할 수 없습니다. 잠시 후 다시 요청해 주세요." } });
});

module.exports = app;
