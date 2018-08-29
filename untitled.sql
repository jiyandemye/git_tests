select "oneTimeReward"->'crypto'->'value' as "amountInUSD", "oneTimeReward"->'crypto'->'symbol' as "currency", * from "Missions"
where "type" = 'level' and cast("oneTimeReward"->'crypto' as json) is not null
order by "level" asc 


select "oneTimeReward"->'crypto'->'value' as "amountInUSD", "oneTimeReward"->'crypto'->'symbol' as "currency", * from "Missions"
where "type" = 'level' and cast("oneTimeReward"->'crypto' as json) is not null
order by "level" asc 



select * from "UserMissions" where "UserMissions"."level" in (1, 5, 9, 12, 16, 21, 24, 100, 150, 200) and "UserMissions"."state" = 'completed'


select "Missions"."oneTimeReward"->'crypto'->'value' as "amountInUSD", "Missions"."oneTimeReward"->'crypto'->'symbol' as "currency", * from "Missions"
inner join "UserMissions" on "UserMissions"."level" = "Missions"."level" 
where "Missions"."type" = 'level' and cast("Missions"."oneTimeReward"->'crypto' as json) is not null


select "Missions"."oneTimeReward"->'crypto'->'value' as "amountInUSD", "Missions"."oneTimeReward"->'crypto'->'symbol' as "currency", * from "Missions"
inner join "UserMissions" on "UserMissions"."missionId" = "Missions"."id" 
where "UserMissions"."type" = 'level' and "UserMissions"."state" = 'completed' and cast("Missions"."oneTimeReward"->'crypto' as json) is not null



Total Crypto Won 

select "Missions"."oneTimeReward"->'crypto'->'value' as "amountInUSD", "Missions"."oneTimeReward"->'crypto'->'symbol' as "currency" from "Missions"
inner join "UserMissions" on "UserMissions"."missionId" = "Missions"."id" 
where "UserMissions"."type" = 'level' and "UserMissions"."state" = 'completed' and cast("Missions"."oneTimeReward"->'crypto' as json) is not null
group by currency




select *, "Missions"."oneTimeReward"->'crypto'->'value' as "amountInUSD", "Missions"."oneTimeReward"->'crypto'->'symbol' as "currency" from "UserMissions"
inner join "Missions" on "UserMissions"."missionId" = "Missions"."id" 
where "UserMissions"."type" = 'level' and "UserMissions"."state" = 'completed' and cast("Missions"."oneTimeReward"->'crypto' as json) is not null



















-----------------------------------------------------------------

#All Users Who Completed Levels That Award Crypto:
select *, "Missions"."oneTimeReward"->'crypto'->'value' as "amountInUSD", "Missions"."oneTimeReward"->'crypto'->'symbol' as "currency" from "UserMissions"
inner join "Missions" on "UserMissions"."missionId" = "Missions"."id" 
where "UserMissions"."type" = 'level' and "UserMissions"."state" = 'completed' and cast("Missions"."oneTimeReward"->'crypto' as json) is not null


#Crypto Winners by Currency
select "Missions"."oneTimeReward"->'crypto'->'symbol' as "currency", count("UserMissions"."userId") from "UserMissions"
inner join "Missions" on "UserMissions"."missionId" = "Missions"."id" 
where "UserMissions"."type" = 'level' and "UserMissions"."state" = 'completed' and cast("Missions"."oneTimeReward"->'crypto' as json) is not null
group by "Missions"."oneTimeReward"->'crypto'->'symbol'

#Crypto Winners by Currency by whether it was claimed or not
select "Missions"."oneTimeReward"->'crypto'->'symbol' as "currency", "UserMissions"."oneTimeRewardClaimed", count("UserMissions"."userId") from "UserMissions"
inner join "Missions" on "UserMissions"."missionId" = "Missions"."id" 
where "UserMissions"."type" = 'level' and "UserMissions"."state" = 'completed' and cast("Missions"."oneTimeReward"->'crypto' as json) is not null
group by "Missions"."oneTimeReward"->'crypto'->'symbol', "UserMissions"."oneTimeRewardClaimed"

#Crypto Winners by level Achieved
select "UserMissions"."level", count("UserMissions"."userId") from "UserMissions"
inner join "Missions" on "UserMissions"."missionId" = "Missions"."id" 
where "UserMissions"."type" = 'level' and "UserMissions"."state" = 'completed' and cast("Missions"."oneTimeReward"->'crypto' as json) is not null
group by "UserMissions"."level"
order by "UserMissions"."level" asc
 
#Crypto Winners by level Achieved and whether it was claimed or not
select "UserMissions"."level", "UserMissions"."oneTimeRewardClaimed", count("UserMissions"."userId") from "UserMissions"
inner join "Missions" on "UserMissions"."missionId" = "Missions"."id" 
where "UserMissions"."type" = 'level' and "UserMissions"."state" = 'completed' and cast("Missions"."oneTimeReward"->'crypto' as json) is not null
group by "UserMissions"."level", "UserMissions"."oneTimeRewardClaimed"
order by "UserMissions"."level" asc



#Crypto Amount Won By Level Achieved



#metrics from Crypto Transactions

# average crypto payout 
select avg("amount") from "CryptoTransactions" inner join "Users" on ("CryptoTransactions"."userId" = "Users"."id")
where "type" = 'payout' and "CryptoTransactions"."state" in ('completed', 'hold', 'pending')
#and "CryptoTransactions"."createdAt" < :endDate
#and "CryptoTransactions"."createdAt" > :startDate

#unique crypto payouts
select count(*) from "CryptoTransactions" inner join "Users" on ("CryptoTransactions"."userId" = "Users"."id")
where "type" = 'payout' and "CryptoTransactions"."state" in ('completed', 'hold', 'pending')
#and "CryptoTransactions"."createdAt" < :endDate
#and "CryptoTransactions"."createdAt" > :startDate


# average crypto withdrawal 
select avg("amount") from "CryptoTransactions" inner join "Users" on ("CryptoTransactions"."userId" = "Users"."id")
where "type" = 'withdrawal' and "CryptoTransactions"."state" in ('completed', 'hold', 'pending')
#and "CryptoTransactions"."createdAt" < :endDate
#and "CryptoTransactions"."createdAt" > :startDate

# unique crypto withdrawers
select avg("amount") from "CryptoTransactions" inner join "Users" on ("CryptoTransactions"."userId" = "Users"."id")
where "type" = 'withdrawal' and "CryptoTransactions"."state" in ('completed', 'hold', 'pending')
#and "CryptoTransactions"."createdAt" < :endDate
#and "CryptoTransactions"."createdAt" > :startDate

# total payouts
select sum("amount") from "CryptoTransactions" inner join "Users" on ("CryptoTransactions"."userId" = "Users"."id")
where "type" = 'payout' and "CryptoTransactions"."state" in ('completed', 'hold', 'pending')
#and "CryptoTransactions"."createdAt" < :endDate
#and "CryptoTransactions"."createdAt" > :startDate

# total withdrawals
select sum("amount") from "CryptoTransactions" inner join "Users" on ("CryptoTransactions"."userId" = "Users"."id")
where "type" = 'withdrawal' and "CryptoTransactions"."state" in ('completed', 'hold', 'pending')
#and "CryptoTransactions"."createdAt" < :endDate
#and "CryptoTransactions"."createdAt" > :startDate






/* Cash won */
select "v"."currencyName", coalesce("g"."cryptoWon", 0) as "cryptoWon" from

(select "CryptoTransactions"."cryptoTokenSymbol" as "type", sum((0 || "value")::float) as "cashWon" from "Prizes"
inner join "Games" on ("Prizes"."gameId" = "Games"."id")
inner join "Users" on ("Prizes"."userId" = "Users"."id")
:afUserInfo
where "Prizes"."type" = 'cash'
and "Prizes"."createdAt" < :endDate
and "Prizes"."createdAt" > :startDate
and :userCohort

group by "Games"."type"
order by "Games"."type" asc
) as "g"

right join (
	values
    :gamesInfo
    ) as "v"("gameName", "gameDBName", "gameCost")

on "v"."gameDBName" = "g"."type"





#Amounts 
-------

# total crypto won by currency

select "CryptoTransactions"."cryptoTokenSymbol", sum("amount") from "CryptoTransactions" 
:afUserInfo
where "CryptoTransactions"."state" in ('completed', 'hold', 'pending')
group by "CryptoTransactions"."cryptoTokenSymbol"
and "CryptoTransactions"."createdAt" < :endDate
and "CryptoTransactions"."createdAt" > :startDate
and :userCohort

# total crypto payouts by currency

select "CryptoTransactions"."cryptoTokenSymbol", sum("amount") from "CryptoTransactions" 
:afUserInfo
where "type" = 'payout' and "CryptoTransactions"."state" in ('completed', 'hold', 'pending')
group by "CryptoTransactions"."cryptoTokenSymbol"
and "CryptoTransactions"."createdAt" < :endDate
and "CryptoTransactions"."createdAt" > :startDate
and :userCohort

# total crypto withdrawn by currency

select "CryptoTransactions"."cryptoTokenSymbol", sum("amount") from "CryptoTransactions" 
:afUserInfo
where "type" = 'withdrawal' and "CryptoTransactions"."state" in ('completed', 'hold', 'pending')
group by "CryptoTransactions"."cryptoTokenSymbol"
and "CryptoTransactions"."createdAt" < :endDate
and "CryptoTransactions"."createdAt" > :startDate
and :userCohort


# percentage of crypto withdrawn by currency (needs to be worked on)

select "CryptoTransactions"."cryptoTokenSymbol", sum("amount"), (100.0 * item.N) / total.N as Pct
       count(*) from "CryptoTransactions" 
:afUserInfo
where "type" = 'withdrawal' and "CryptoTransactions"."state" in ('completed', 'hold', 'pending')
group by "CryptoTransactions"."cryptoTokenSymbol"
and "CryptoTransactions"."createdAt" < :endDate
and "CryptoTransactions"."createdAt" > :startDate
and :userCohort


# Users
-------
# total crypto winners by currency

select "CryptoTransactions"."cryptoTokenSymbol", count("userId") from "CryptoTransactions" 
:afUserInfo
where "CryptoTransactions"."state" in ('completed', 'hold', 'pending')
group by "CryptoTransactions"."cryptoTokenSymbol"
and "CryptoTransactions"."createdAt" < :endDate
and "CryptoTransactions"."createdAt" > :startDate
and :userCohort

# total crypto winners-non-withdrawers by currency

select "CryptoTransactions"."cryptoTokenSymbol", count("userId") from "CryptoTransactions" 
:afUserInfo
where "type" = 'payout' and "CryptoTransactions"."state" in ('completed', 'hold', 'pending')
group by "CryptoTransactions"."cryptoTokenSymbol"
and "CryptoTransactions"."createdAt" < :endDate
and "CryptoTransactions"."createdAt" > :startDate
and :userCohort


# total crypto withdrawers by currency

select "CryptoTransactions"."cryptoTokenSymbol", count("userId") from "CryptoTransactions" 
:afUserInfo
where "type" = 'withdrawal' and "CryptoTransactions"."state" in ('completed', 'hold', 'pending')
group by "CryptoTransactions"."cryptoTokenSymbol"
and "CryptoTransactions"."createdAt" < :endDate
and "CryptoTransactions"."createdAt" > :startDate
and :userCohort



# Unique Users
--------------




















