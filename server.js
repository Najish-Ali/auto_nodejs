const express = require("express");
const os = require("os");

const app = express();
const PORT = process.env.PORT || 3000;

// Health check route
app.get("/health", (req, res) => {
  res.json({ status: "UP", server: os.hostname() });
});

// Main route
app.get("/", (req, res) => {
  res.send(`Node.js app is running on port ${PORT}`);
});

// Start server
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
