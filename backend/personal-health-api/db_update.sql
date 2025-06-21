-- 修改health_plan表中的target_calories列为steps
ALTER TABLE health_plan CHANGE COLUMN target_calories steps INT;

-- 如果需要从头创建这个表，这里是完整的建表语句
/*
CREATE TABLE IF NOT EXISTS health_plan (
  id INT PRIMARY KEY,
  user_id INT NOT NULL,
  plan_date DATE NOT NULL,
  steps INT,
  exercise_minutes INT,
  exercise_type VARCHAR(50),
  calories_burned INT,
  create_time DATETIME NOT NULL,
  update_time DATETIME,
  FOREIGN KEY (user_id) REFERENCES user(id)
);
*/ 