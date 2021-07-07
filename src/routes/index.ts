import express from 'express'

const Router = express.Router()

type Indexed = {
    [key: string]: any;
};

Router.get('/', (req, res) => {
    res.status(200).send({
        message: 'Blog Service OK',
    })
})
export default Router