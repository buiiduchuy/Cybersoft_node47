import connect from "../../db.js";

import initModels from "../models/init-models.js";
import sequelize from "../routes/connect.js";
import {Op} from "sequelize" // operator

// tạo object model đại diện cho tất cả model của orm
const model = initModels(sequelize);

const getUsers = (req,res)=>{
  res.status(200).json({message: "get-user"});
}

const createUSers = (req,res)=> {
  let body = req.body
  console.log(body)
  res.send(body)
}

const getUserDb = async (req,res) => {
  const [data] = await connect.query(`
      SELECT * FROM users
    `)
    res.send(data);
}

const getUserOrm = async (req,res)=> {
  try {
    // seclect * from users
    // where full_name like '%John%'

    let data = await model.users.findAll({
      where: {
        full_name: {
          [Op.like] : `%John%`
        }
      },
      attributes: ["user_id" , "full_name", "email"],
      include: [
        {
          model: model.video, // join với table video
          as: 'videos',
          required: true // join table theo kiểu inner join , default là left join
          // attributes: ["video_name"]
        }
      ]
    });
    return res.status(200).json(data)
  } catch (error) {
    return res.status(500).json({message: "Error from ORM"})
  }
}

const getUserOrmById = async(req,res)=> {
  let {id} = req.params
  try {
    let data = await model.users.findOne({
      where: {
        user_id: id
      }
    })
    return res.status(200).json(data)
  } catch (error) {
    return res.status(500).json({message: "Error API get user by id"})
  }
}

const createUSerOrm = async (req,res)=> {
  try {
    let {full_name, email} = req.body
    await model.users.create({
      full_name : full_name,
      email: email,
    })
    return res.status(201).json({message: "Create user success"})
  } catch (error) {
    return res.status(500).json({message: "Error AP create user orm"})
  }
}

export {
  getUsers, createUSers, getUserDb, getUserOrm, getUserOrmById, createUSerOrm
}