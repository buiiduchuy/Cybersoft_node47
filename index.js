import express from 'express';
import connect from './db.js';
import rootRoutes from './src/routes/rootRoutes.js';

// tạo object tổng của express
const app = express();

// Thêm middlware để convert string về json với API POST và PUT
app.use(express.json());

// import rootRoutes vào index.js
app.use(rootRoutes)


// viết API hello word
app.get("/hello-world",(req,res) => {
  res.send("hello-world");
})

app.get("/health-check",(req,res) => {
  res.send("Server is normally")
})

// lấy thông tin data từ params , query string , headers , body
// http://localhost:8080/get-user/1
app.get("/get-user/:id/:hoTen",(req,res)=> {
  // lấy id từ url
  let {id,hoTen} = req.params;
  let {queryString} = req.query
  let {token,authorization} = req.headers
  let headers = req.headers
  res.send({id,hoTen,queryString,token,authorization});
})

// app.get("/get-user-db", async (req,res) => {
//   const [data] = await connect.query(`
//       SELECT * FROM users
//     `)
//     res.send(data);
// })

// lấy body từ API POST (create) và PUT (Update)
// '{ "id": 1,"hoTen": "Halo"}'
// app.post("/create-user",(req,res)=> {
//   let body = req.body
//   res.send(body)
// })


app.post("/create-user-db" , async (req,res)=> {
  const query = `
    INSERT INTO users(full_name,email,pass_word) VALUES
    (?,?,?)
  `
  let body = req.body;
  let {full_name,email,pass_word} = body
  const [data] = await connect.execute(query, [full_name,email,pass_word])
  res.send(data)
})

// define port for BE
app.listen(8080,() => {
  console.log('BE starting with port 8080');
})