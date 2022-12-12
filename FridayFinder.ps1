param (
    [int] $year
)

# Define the list of holidays in Bavaria, Germany
$holidays = @(
    (Get-Date -Year $year -Month 1 -Day 1),
    (Get-Date -Year $year -Month 1 -Day 6),
    (Get-Date -Year $year -Month 4 -Day 2),
    (Get-Date -Year $year -Month 5 -Day 1),
    (Get-Date -Year $year -Month 5 -Day 14),
    (Get-Date -Year $year -Month 5 -Day 24),
    (Get-Date -Year $year -Month 5 -Day 31),
    (Get-Date -Year $year -Month 6 -Day 20),
    (Get-Date -Year $year -Month 8 -Day 15),
    (Get-Date -Year $year -Month 10 -Day 3),
    (Get-Date -Year $year -Month 11 -Day 1),
    (Get-Date -Year $year -Month 12 -Day 24),
    (Get-Date -Year $year -Month 12 -Day 25),
    (Get-Date -Year $year -Month 12 -Day 26),
    (Get-Date -Year $year -Month 12 -Day 31)
)

# Get all the dates in the given year
$startDate = Get-Date -Year $year -Month 1 -Day 1
Write-Output $startDate
$endDate = Get-Date -Year $year -Month 12 -Day 31
Write-Output $endDate
$dates = @()

# Use a for loop to add each date to the array
for ($i = $startDate; $i -le $endDate; $i = $i.AddDays(1)) {
    $dates += $i
}

Write-Output $dates
# Filter the dates to only include Fridays
$fridays = $dates | Where-Object { $_.DayOfWeek -eq "Friday" }

# Filter the dates to exclude holidays
$nonHolidays = $fridays | Where-Object { $holidays -notcontains $_ }

# Format the dates as strings in the yyyy-MM-dd format
$formattedFridays = $nonHolidays | ForEach-Object { $_.ToString("yyyy-MM-dd") }

# Save the formatted dates to a text file, with each date on a separate line
$formattedFridays | Out-File -FilePath "Fridays-$year.txt" -Encoding utf8
