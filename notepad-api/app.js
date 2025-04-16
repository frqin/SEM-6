console.log('Starting the server...'); // Tambahkan di awal file app.js

const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const fs = require('fs');

const app = express();
const PORT = 3000;

app.use(cors());
app.use(bodyParser.json());

const filePath = './notes.json';

// Endpoint untuk mendapatkan semua catatan
app.get('/api/notes', (req, res) => {
  const data = fs.existsSync(filePath) ? JSON.parse(fs.readFileSync(filePath)) : [];
  res.json(data);
});

// Endpoint untuk menambah catatan baru
app.post('/api/notes', (req, res) => {
  const data = fs.existsSync(filePath) ? JSON.parse(fs.readFileSync(filePath)) : [];
  const newNote = {
    id: Date.now(),
    title: req.body.title,
    content: req.body.content
  };
  data.push(newNote);
  fs.writeFileSync(filePath, JSON.stringify(data, null, 2));
  res.status(201).json(newNote);
});

app.listen(PORT, () => {
  console.log(`Server running at http://localhost:${PORT}`);
});
