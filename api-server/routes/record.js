var express = require('express');
var router = express.Router();

const record = require("../models/recordModel");

// 운동 기록 목록 조회
router.get("/sports/:no", async (req, res, next) => {
  try{
    const id = Number(req.params.no);
    const list = await record.findsportsrecord(id);
    res.json(list);
  }catch(err){
    next(err);
  }
});

// 음식 기록 목록 조회
router.get("/food/:no", async (req, res, next) => {
  try{
    const id = Number(req.params.no);
    const list = await record.findfoodrecord(id);
    res.json(list);
  }catch(err){
    next(err);
  }
});

// 운동 기록 등록
router.post("/sportsadd", async (req, res, next) => {
  try{
    const id = await record.createsportsrecord(req.body);
    res.json({ id });
  }catch(err){
    next(err);
  }
});

// 음식 기록 등록
router.post("/foodadd", async (req, res, next) => {
  try{
    const id = await record.createfoodrecord(req.body);
    res.json({ id });
  }catch(err){
    next(err);
  }
});

// 운동 기록 삭제
router.delete("/sportsdel/:no", async (req, res, next) => {
  try{
    const id = Number(req.params.no);
    const count = await record.deletesportsrecord(id);
    res.json({ count });
  }catch(err){
    next(err);
  }
});

// 음식 기록 삭제
router.delete("/fooddel/:no", async (req, res, next) => {
  try{
    const id = Number(req.params.no);
    const count = await record.deletefoodrecord(id);
    res.json({ count });
  }catch(err){
    next(err);
  }
});

module.exports = router;