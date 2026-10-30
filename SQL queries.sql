-- 1. Выбрать лаборатории, которые заняты по понедельникам 2 парой.
SELECT DISTINCT lab_number 
FROM schedule 
WHERE weekday = 'Понедельник' 
  AND lesson_number = 2;


-- 2. Выбрать группы 2 курса, которые занимаются в 106 лаборатории по средам.
SELECT DISTINCT group_number 
FROM schedule 
WHERE lab_number = '106' 
  AND weekday = 'Среда' 
  AND SUBSTRING(group_number, 5, 1) = '2';


-- 3. Создать таблицу, содержащую данные 1 запроса с указанием всех данных таблицы «расписание» и групп, которыми будут заняты лаборатории.
CREATE TABLE new_schedule AS
SELECT group_number, lab_number, discipline, weekday, lesson_number
FROM schedule 
WHERE weekday = 'Понедельник' 
  AND lesson_number = 2;


-- 4. В созданную таблицу добавить расписание занятий всех групп первого курса.
INSERT INTO new_schedule (group_number, lab_number, discipline, weekday, lesson_number)
SELECT group_number, lab_number, discipline, weekday, lesson_number
FROM schedule
WHERE SUBSTRING(group_number, 5, 1) = '1';


-- 5. В созданной таблице сдвинуть все пары на одну вверх по вторникам, четвергам и субботам.
UPDATE new_schedule
SET lesson_number = lesson_number - 1
WHERE weekday IN ('Вторник', 'Четверг', 'Суббота');


-- 6. Удалить из созданной таблицы все занятия в 106 лаборатории по понедельникам.
DELETE FROM new_schedule
WHERE lab_number = '106' 
  AND weekday = 'Понедельник';


-- 7. Посчитать количество занятий по дням недели для каждой лаборатории.
SELECT lab_number, weekday, COUNT(*) AS lessons_count
FROM schedule
GROUP BY lab_number, weekday
ORDER BY lab_number, weekday;
