-- https://learnxinyminutes.com/docs/ru-ru/lua-ru/ ссылка для быстрого ознакомления с основами языка LUA

-- Скрипт реализует мигание светодиодов на базовой плате случайными цветами

-- Упрощение вызова функции распаковки таблиц из модуля table
local unpack = table.unpack
-- Количество светодиодов на базовой плате
local ledNumber = 25
-- Создание порта управления светодиодами
local leds = Ledbar.new(ledNumber)

-- Функция, изменяющая цвет 4-х RGB светодиодов на базовой плате
local function changeColor(col)
    for i=0, ledNumber - 1, 1 do
        leds:set(i, unpack(col))
    end
end

-- Функция, реализующая выключение таймера и изменение цвета светодиодов на красный
local function emergency()
    -- Остановка таймера
    timerRandomLED:stop()
    -- Изменение цвета светодиодов (через секунду - т.к. после остановки таймера timerRandomLED
    -- его функция выполнится еще раз)
    Timer.callLater(1, function () changeColor({1, 0, 0}) end)
end

-- Функция обработки событий, автоматически вызывается автопилотом
function callback(event)
    -- Вызов функции emergency() при низком напряжении на аккумуляторе
    if (event == Ev.LOW_VOLTAGE2) then
        emergency()
    end
end