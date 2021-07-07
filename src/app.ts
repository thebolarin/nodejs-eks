import express from 'express';
import 'express-async-errors';
import { json } from 'body-parser';
import { config } from 'dotenv';
import swaggerUi from 'swagger-ui-express'
import Router from './routes/index'
// import specs from '../doc/swagger.json'

config()

const app = express();
app.set('trust proxy', true);
app.set("port", process.env.PORT || 3000);
app.use(json());

app.use('/api', Router);

// app.use(
//     '/api/protected/documentation',
//     swaggerUi.serve,
//     swaggerUi.setup(specs, { explorer: true }),
//   )

export { app };
