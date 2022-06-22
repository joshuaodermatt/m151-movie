import {Router} from 'express';
import {
    list,
    remove,
    formFunction,
    save,
} from './repository.js';

const router = Router();

router.get('/', list);
router.get('/delete/:id', remove);
router.get('/form/:id?', formFunction);
router.post('/save', save);

export {router};
