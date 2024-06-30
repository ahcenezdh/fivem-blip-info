fx_version 'cerulean'
use_experimental_fxv2_oal 'yes'
lua54 'yes'
game 'gta5'
name 'Blip Info Utility'
author 'glitchdetector'
contact 'glitchdetector@gmail.com'
version '1.0.0'

description 'Enables the ability to assign extra information for blips, visible when hovering over them in the pause menu map'
usage [[
    exports['blip_info']:ResetBlipInfo(blip)
    exports['blip_info']:SetBlipInfo(blip, infoData)
    exports['blip_info']:SetBlipInfoTitle(blip, title, rockstarVerified)
    exports['blip_info']:SetBlipInfoImage(blip, dict, tex)
    exports['blip_info']:SetBlipInfoEconomy(blip, rp, money)
    exports['blip_info']:AddBlipInfoText(blip, leftText, rightText)
    exports['blip_info']:AddBlipInfoName(blip, leftText, rightText)
    exports['blip_info']:AddBlipInfoHeader(blip, leftText, rightText)
    exports['blip_info']:AddBlipInfoIcon(blip, leftText, rightText, iconId, iconColor, checked)
]]

client_script 'blip_info.lua'

exports {
    'ResetBlipInfo',
    'SetBlipInfo',
    'SetBlipInfoTitle',
    'SetBlipInfoImage',
    'SetBlipInfoEconomy',
    'AddBlipInfoText',
    'AddBlipInfoName',
    'AddBlipInfoHeader',
    'AddBlipInfoIcon'
}
