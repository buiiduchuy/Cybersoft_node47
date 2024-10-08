import express from "express";
import { getUsers, createUSers, getUserDb, getUserOrm, getUserOrmById , createUSerOrm} from "../controllers/userControllers.js";

const userRoutes = express.Router();

// define API get list user

userRoutes.get("/get-user",getUsers)
userRoutes.post("/create-user",createUSers)
userRoutes.get("/get-user-db", getUserDb)
userRoutes.get("/get-user-orm", getUserOrm)
userRoutes.get("/get-user-orm/:id", getUserOrmById)
userRoutes.post("/create-user-orm",createUSerOrm)

export default userRoutes;