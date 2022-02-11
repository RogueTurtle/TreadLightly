local composer = require("composer")

local options = {
    effect = "fade",
    time = 400,
    params = {level="Test Level"}
}

composer.gotoScene("game", options)