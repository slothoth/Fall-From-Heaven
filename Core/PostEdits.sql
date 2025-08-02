UPDATE Units SET Maintenance='0' WHERE Maintenance='1';
UPDATE Units SET BaseMoves= BaseMoves + 1 WHERE BaseMoves >0;