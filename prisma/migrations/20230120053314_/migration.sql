/*
  Warnings:

  - You are about to drop the `day` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the column `week_id` on the `habit_week_days` table. All the data in the column will be lost.
  - Added the required column `week_day` to the `habit_week_days` table without a default value. This is not possible if the table is not empty.

*/
-- DropIndex
DROP INDEX "day_date_key";

-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "day";
PRAGMA foreign_keys=on;

-- CreateTable
CREATE TABLE "days" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "date" DATETIME NOT NULL
);

-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_habit_week_days" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "habit_id" TEXT NOT NULL,
    "week_day" INTEGER NOT NULL
);
INSERT INTO "new_habit_week_days" ("habit_id", "id") SELECT "habit_id", "id" FROM "habit_week_days";
DROP TABLE "habit_week_days";
ALTER TABLE "new_habit_week_days" RENAME TO "habit_week_days";
CREATE INDEX "habit_week_days_habit_id_idx" ON "habit_week_days"("habit_id");
CREATE UNIQUE INDEX "habit_week_days_habit_id_week_day_key" ON "habit_week_days"("habit_id", "week_day");
CREATE TABLE "new_day_habits" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "day_id" TEXT NOT NULL,
    "habit_id" TEXT NOT NULL
);
INSERT INTO "new_day_habits" ("day_id", "habit_id", "id") SELECT "day_id", "habit_id", "id" FROM "day_habits";
DROP TABLE "day_habits";
ALTER TABLE "new_day_habits" RENAME TO "day_habits";
CREATE INDEX "day_habits_habit_id_idx" ON "day_habits"("habit_id");
CREATE UNIQUE INDEX "day_habits_day_id_habit_id_key" ON "day_habits"("day_id", "habit_id");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;

-- CreateIndex
CREATE UNIQUE INDEX "days_date_key" ON "days"("date");
