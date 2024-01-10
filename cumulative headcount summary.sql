WITH EmpCnt AS (
SELECT count([EmpID]) as cnt
,year(cast([DateofHire] as date)) as [year]
FROM [Test].[dbo].[HRDataset_v14]
group by year(cast([DateofHire] as date))
)
, TermCnt AS (
SELECT count([EmpID]) as cntterm
,year(cast([DateofTermination] as date)) as [Terminationyear]
FROM [Test].[dbo].[HRDataset_v14]
where year(cast([DateofTermination] as date)) <> 1900
group by year(cast([DateofTermination] as date))
)

SELECT 
    [year],
	case when cntterm is null then
	SUM(cnt) OVER (ORDER BY [year])
	else 
    SUM(cnt) OVER (ORDER BY [year]) - SUM(cntterm) OVER (ORDER BY [year]) 
	end
	AS CumulativeSum,	
	case when cntterm is null then
	0
	else 
    SUM(cntterm) OVER (ORDER BY [year]) 
	end
	AS CumulativeTerminationSum,	
	case when cntterm is null then
	0
	else 
    cntterm 
	end
	AS TerminationSum
FROM 
    EmpCnt a
	left join TermCnt b
	on [year] = [Terminationyear]
