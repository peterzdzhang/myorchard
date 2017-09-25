USE FaureciaBM
GO
exec sp_rename 'Faurecia_FTL_ProjectRevisionContentRecord.[Function]'
,'ProjectFunction'
GO
exec sp_rename 'Faurecia_FTL_ProjectRevisionContentRecord.[CustomerSpecificationReference ]'
,'CustomerSpecificationReference'
GO
exec sp_rename 'Faurecia_FTL_ProjectRevisionContentRecord.[SatisfactionLevel ]'
,'SatisfactionLevel'
GO
--Travel
UPDATE Faurecia_ADL_ADLCostRecord SET ActivityTypeRecord_Id=2200+(ActivityTypeRecord_Id-27)*100
WHERE ActivityTypeRecord_Id>=27 AND ActivityTypeRecord_Id<=29;
GO
DELETE FROM Faurecia_ADL_ActivityTypeRecord WHERE Id>=27 AND Id<=29
GO
--DV
UPDATE Faurecia_ADL_ADLCostRecord SET ActivityTypeRecord_Id=2500+(ActivityTypeRecord_Id-30)*100
WHERE ActivityTypeRecord_Id>=30 AND ActivityTypeRecord_Id<=33;
GO
DELETE FROM Faurecia_ADL_ActivityTypeRecord WHERE Id>=30 AND Id<=33
GO
--PV
UPDATE Faurecia_ADL_ADLCostRecord SET ActivityTypeRecord_Id=2900+(ActivityTypeRecord_Id-34)*100
WHERE ActivityTypeRecord_Id>=34 AND ActivityTypeRecord_Id<=35;
GO
DELETE FROM Faurecia_ADL_ActivityTypeRecord WHERE Id>=34 AND Id<=35
GO
--FEA
UPDATE Faurecia_ADL_ADLCostRecord SET ActivityTypeRecord_Id=3300+(ActivityTypeRecord_Id-38)*100
WHERE ActivityTypeRecord_Id>=38 AND ActivityTypeRecord_Id<=38;
GO
DELETE FROM Faurecia_ADL_ActivityTypeRecord WHERE Id>=38 AND Id<=38
GO
--External
UPDATE Faurecia_ADL_ADLCostRecord SET ActivityTypeRecord_Id=3100+(ActivityTypeRecord_Id-36)*100
WHERE ActivityTypeRecord_Id>=36 AND ActivityTypeRecord_Id<=37;
GO
DELETE FROM Faurecia_ADL_ActivityTypeRecord WHERE Id>=36 AND Id<=37
GO
UPDATE a SET a.IsUsed=0
FROM [Faurecia_ADL_ActivityTypeRecord] a
WHERE IsUsed=1
AND EXISTS(SELECT 1 FROM [Faurecia_ADL_ActivityTypeRecord] b
            WHERE b.ActivityType=a.ActivityType
			AND b.CostCenter=a.CostCenter
			AND b.RMBHour=a.RMBHour
			AND b.Comment=a.Comment
			AND b.Id>a.Id)
GO


SELECT [ADLRecord_Id],[Year],ActivityTypeRecord_Id
,MAX(Jan) Jan,Max(Feb) Feb,Max(Mar) Mar,Max(Apr) Apr,Max(May) May
,Max(Jun) Jun,Max(Jul) Jul,Max(Aug) Aug,Max(Sep) Sep,Max(Oct) Oct,Max(Nov) Nov,Max(Dev) Dev
INTO #TEMP_ADLHeadCountRecord
FROM Faurecia_ADL_ADLHeadCountRecord a
where  EXISTS(SELECT 1 FROM Faurecia_ADL_ADLHeadCountRecord b WHERE b.ADLRecord_Id=a.ADLRecord_Id 
AND b.ActivityTypeRecord_Id=a.ActivityTypeRecord_Id
AND b.Year=a.Year AND b.Id!=a.Id)
GROUP BY [ADLRecord_Id],[Year],ActivityTypeRecord_Id;

UPDATE a
SET a.Jan=b.Jan,a.Feb=b.Feb,a.Mar=b.Mar,a.Apr=b.Apr,a.May=b.May,a.Jun=b.Jun,a.Jul=b.Jul,a.Aug=b.Aug,a.Sep=b.Sep,
a.Oct=b.Oct,a.Nov=b.Nov,a.Dev=b.Dev
FROM Faurecia_ADL_ADLHeadCountRecord a
INNER JOIN #TEMP_ADLHeadCountRecord b ON a.ADLRecord_Id=b.ADLRecord_Id AND a.ActivityTypeRecord_Id=b.ActivityTypeRecord_Id AND a.Year=b.Year;

DROP TABLE #TEMP_ADLHeadCountRecord;

DELETE a 
FROM Faurecia_ADL_ADLHeadCountRecord a
WHERE EXISTS(SELECT 1 FROM Faurecia_ADL_ADLHeadCountRecord b WHERE b.ADLRecord_Id=a.ADLRecord_Id 
			 AND b.ActivityTypeRecord_Id=a.ActivityTypeRecord_Id
             AND b.Year=a.Year AND b.Id>a.Id)
GO

SELECT [ADLRecord_Id],[Year],ActivityTypeRecord_Id
,MAX(Jan) Jan,Max(Feb) Feb,Max(Mar) Mar,Max(Apr) Apr,Max(May) May
,Max(Jun) Jun,Max(Jul) Jul,Max(Aug) Aug,Max(Sep) Sep,Max(Oct) Oct,Max(Nov) Nov,Max(Dev) Dev
INTO #TEMP_ADLCostRecord
FROM Faurecia_ADL_ADLCostRecord a
where  EXISTS(SELECT 1 FROM Faurecia_ADL_ADLCostRecord b WHERE b.ADLRecord_Id=a.ADLRecord_Id 
AND b.ActivityTypeRecord_Id=a.ActivityTypeRecord_Id
AND b.Year=a.Year AND b.Id!=a.Id)
GROUP BY [ADLRecord_Id],[Year],ActivityTypeRecord_Id;

UPDATE a
SET a.Jan=b.Jan,a.Feb=b.Feb,a.Mar=b.Mar,a.Apr=b.Apr,a.May=b.May,a.Jun=b.Jun,a.Jul=b.Jul,a.Aug=b.Aug,a.Sep=b.Sep,
a.Oct=b.Oct,a.Nov=b.Nov,a.Dev=b.Dev
FROM Faurecia_ADL_ADLCostRecord a
INNER JOIN #TEMP_ADLCostRecord b ON a.ADLRecord_Id=b.ADLRecord_Id AND a.ActivityTypeRecord_Id=b.ActivityTypeRecord_Id AND a.Year=b.Year;

DROP TABLE #TEMP_ADLCostRecord;

DELETE a FROM [FaureciaBM].[dbo].Faurecia_ADL_ADLCostRecord a
where  EXISTS(SELECT 1 FROM Faurecia_ADL_ADLCostRecord b WHERE b.ADLRecord_Id=a.ADLRecord_Id 
AND b.ActivityTypeRecord_Id=a.ActivityTypeRecord_Id
AND b.Year=a.Year AND b.Id>a.Id);

GO