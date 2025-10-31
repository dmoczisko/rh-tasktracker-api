import express from "express";

const app = express();
app.use(express.json());

let tasks = [
    { id: 1, title: "Learn RHEL" },
    { id: 2, title: "Install Podman" },
];

app.get("/tasks", (req, res) => {
    res.json(tasks);
});

app.get('/health', (req, res) => {
    res.status(200).json({ status: 'ok', uptime: process.uptime() });
});

app.post("/tasks", (req, res) => {
    const newTask = {
        id: tasks.length + 1,
        title: req.body.title,
    };
    tasks.push(newTask);
    res.status(201).json(newTask);
});

app.delete("/tasks/:id", (req, res) => {
    const id = parseInt(req.params.id);
    tasks = tasks.filter(task => task.id !== id);
    res.status(204).send();
});

const PORT = 3000;
app.listen(PORT, () => console.log(`TaskTracker API running on port ${PORT}`));
