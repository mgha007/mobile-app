const app =require('./app');
const port=process.env.PORT || 3000; 

app.get('/',(req,res)=>{
    res.send('hello ghalleb')
});
app.listen(port,()=>{
    console.log(`server listenig on port http://localhost:${port}`);
})