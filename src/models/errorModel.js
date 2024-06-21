// 引入 Prisma Client
const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();
class ErrorModel {
  async createError(data) {
    // 将错误信息写入数据库
    try {
      console.log(data)
      const error = await prisma.error.create({
        data: {
          hash,
          fileName,
          lineNumber,
          columnNumber,
          domInfo,
          scriptURI,
        },
      });
      return error;
    } catch (err) {
      console.log(err);
    }
  }
}
module.exports = ErrorModel;
