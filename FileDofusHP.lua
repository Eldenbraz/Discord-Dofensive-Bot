{
    "id": 4,
    "formulaName": "monster_life",
    "luaFormula": 
        "local monsterLifeCoef = 1.625
        local monsterLifeSignificativeNumbers = 2
        
        function params()
            return {\"monster_level\", \"stat_ratio\"}
        end
        
        function roundToNearest(n, decimalCount)
            decimalCount = decimalCount or 0
            local offset = math.pow(10, decimalCount)
            local res = n * offset
            if res % 1 >= 0.5 then
                res = math.ceil(res)
            else
                res = math.floor(res)
            end
            return res / offset
        end
        
        function roundToSignificantFigures(num, n)
            if num == 0 then
                return 0
            end
            local d = math.ceil(math.log(math.abs(num)) / math.log(10))
            if d <= n then
                return num
            end
            local power = math.floor(d - n)
            local magnitude = math.floor(math.pow(10, power))
            return roundToNearest(num / magnitude) * magnitude
        end
        
        function main()
            if stat_ratio == nil then
                return 0
            end
            
            return math.max(1, roundToSignificantFigures(math.floor(stat_ratio * math.pow(monster_level, monsterLifeCoef)), monsterLifeSignificativeNumbers))
        end"
},

--Calcul 1: ( (n * 10^x) / 10^x ) % 1 >= 0,5 ----> arrondi, sinon tronqué
--Calcul 2: ( x / [Tronqué](10^[Tronqué](( [Arrondi](log( |x| )) / log(10) ) - n))) * [Tronqué](10^[Tronqué](( [Arrondi](log( |x| )) / log(10) ) - n))

--Calcul final: [Choisis le + grand](1, Calcul2(([Tronqué]([RATIO]*level^1,625)),2))