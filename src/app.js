const Koa = require('koa');
const app = new Koa();
const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();
// 引入koa-router
const Router = require('@koa/router');
// 实例化路由对象
const router = new Router();
const bodyParser = require('koa-bodyparser');
const body = require('koa-better-body');
const convert = require('koa-convert');
// 解析body中间件
const coBody = require('co-body');
// 使用 bodyParser 中间件解析请求体
app.use(bodyParser());
// 使用 koa-body 中间件，配置以处理多种请求体类型
// 使用 koa-better-body 中间件

const port = 8083;
const initController = require('./controllers/index');

// initController(app);
app.use(async (ctx, next) => {
  ctx.set('Access-Control-Allow-Origin', '*');
  ctx.set('Access-Control-Allow-Headers', 'Content-Type');
  ctx.set('Access-Control-Allow-Methods', '*');
  ctx.set('Content-Type', 'application/json;charset=utf-8');
  await next();
});
// 存储性能数据
let performanceList = [];
// 存储错误数据
let errorList = [];
// 存储录屏数据
let recordScreenList = [];
// 存储白屏检测数据
let whiteScreenList = [];
app.use(router.routes()).use(router.allowedMethods());
router.post('/reportData', async (ctx, next) => {
  try {
    // req.body 不为空时为正常请求，如录屏信息
    let length = Object.keys(ctx.request.body).length;
    if (length) {
      // 提取公共字段
    const {
      type,
      pageUrl,
      time,
      uuid,
      apikey,
      status,
      recordScreenId,
      deviceInfo
    } = ctx.request.body
      const reportData = await prisma.recordScreen.create({
        data: {
          events: ctx.request.body.events,
          recordScreenId: ctx.request.body.recordScreenId
        },
      });
    } else {
      // sendBeacon发送过来的需要用这个来解析
      let params = await coBody.json(ctx.req);
      const { type, pageUrl, time, uuid, apikey, status, recordScreenId, deviceInfo } = params;
      const reportData = await prisma.report.create({
        data: {
          type,
          pageUrl,
          time: new Date(time),
          uuid,
          apikey,
          status,
          browserVersion: deviceInfo.browserVersion,
          browser: deviceInfo.browser,
          osVersion: deviceInfo.osVersion,
          os: deviceInfo.os,
          ua: deviceInfo.ua,
          device: deviceInfo.device,
          deviceType: deviceInfo.device_type,
          recordScreenId: params.recordScreenId
        },
      });
      // 使用 web beacon 上报数据
      if (params.type == 'recordScreen') {
      } else {
        // errorList.push(data);
      }
    }
    ctx.body = {
      code: 200,
      meaage: '上报成功！',
    };
  } catch (err) {
    console.log(err);
    ctx.body = {
      code: 203,
      meaage: '上报失败！',
      err,
    };
  }
});
router.post('/getmap', async (ctx, next) => {
  console.log(ctx.body);
  // const url = data.fileName;
  // let fileUrl = `${url.substring(url.lastIndexOf('/') + 1).trim()}.map`; // map文件路径
  // // 解析sourceMap, 得到源文件路径，是在server下的
  // console.log('🚀 ~ router.post ~ fileUrl:', fileUrl);
  // let consumer = await new sourceMap.SourceMapConsumer(fs.readFileSync(resolve('./' + fileUrl), 'utf8')); // 返回一个promise对象
  // // 解析原始报错数据
  // let result = consumer.originalPositionFor({
  //   line: error.lineNo, // 压缩后的行号
  //   column: error.columnNo, // 压缩后的列号
  // });
  // console.log(result);
  // res.json(result);
  res.send({
    code: 200,
    data: {
      msg: '成功',
    },
  });
});

router.get('/getErrorList', async (ctx, next) => {
  const errors = await prisma.report.findMany();
  ctx.body = {
    code: 200,
    data: errors,
  };
});
router.get('/getRecordScreenId', async (ctx, next) => {
  const id = ctx.query.id
  console.log(id)
  const recordScreen = await prisma.recordScreen.findUnique({
    where: {
      recordScreenId: id,
    },
  });
  if (!recordScreen) {
    return res.status(404).json({ error: 'Record Screen not found' });
  }
  ctx.body = {
    code: 200,
    data: recordScreen,
  };
} );
// 中间件来设置响应头
app.listen(port, () => {
  console.log(`server is running at ${port}`);
});
