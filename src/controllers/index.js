const Router = require('@koa/router');
const router = new Router();
const ErrorController = require('./errorController');
const errorController = new ErrorController();
const SourcemapController = require('./sourcemapController');
const sourcemapController = new SourcemapController();
function initController(app) {
  router.post('/reportData', errorController.createError);
  router.post('/getmap', sourcemapController.getMapInfo);
  app.use(router.routes()).use(router.allowedMethods());
}
module.exports = initController;
