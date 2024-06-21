const ErrorModel = require('../models/errorModel');
const errorModel = new ErrorModel();

class ErrorController {
  async createError(ctx, next) {
    // 写入到数据库
    try {
      const error = await errorModel.createError(ctx.request.body);
      ctx.body = {
        code: 200,
        msg: 'success',
        data: error,
      };
    } catch (err) {
      ctx.body = {
        code: 500,
        msg: 'error',
        data: err,
      };
    }
  }
}
module.exports = ErrorController;
