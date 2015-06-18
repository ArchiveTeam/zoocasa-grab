dofile("urlcode.lua")
dofile("table_show.lua")

local url_count = 0
local tries = 0
local item_type = os.getenv('item_type')
local item_value = os.getenv('item_value')
local item_lang = os.getenv('item_lang')
local item_place = os.getenv('item_place')
local item_specific = os.getenv('item_specific')

local downloaded = {}
local addedtolist = {}

-- do not grab following files:
downloaded["http://assets3.zoocasa.com/assets/favicon-2271d50176e47767bc9ebccdbf8b8f3f.png"] = true
downloaded["http://assets0.zoocasa.com/assets/application-1c1f6769651953fe509f322ffc5587ea.css"] = true
downloaded["http://assets1.zoocasa.com/assets/site/listings/search/index-a76645dbff4a0c5499d15c4d7143a1c0.css"] = true
downloaded["http://assets0.zoocasa.com/assets/site/listings/show-8c4d4a9d984812188833e77158e67c75.css"] = true
downloaded["http://assets0.zoocasa.com/assets/misc/rogers_dmp-e9ebc56619d29f3ed6d1f47303c4bd7f.js"] = true
downloaded["http://www.zoocasa.com/javascripts/configuration.js"] = true
downloaded["http://assets3.zoocasa.com/assets/feature_detection-a5ddd0e379d063f95f7e9bc086ce8168.js"] = true
downloaded["http://assets0.zoocasa.com/assets/misc/typekit-7a38dad0ec02a6e0750fa96301f88ec9.js"] = true
downloaded["http://assets3.zoocasa.com/assets/clear-b12d554d300488e4a1884a30bc6f290f.gif"] = true
downloaded["http://www.google.com/jsapi?autoload=%7B%22modules%22%3A%5B%7B%22name%22%3A%22maps%22%2C%22version%22%3A%223.19%22%2C%22other_params%22%3A%22%26libraries%3Dgeometry%252Cplaces%26sensor%3Dfalse%26client%3Dgme-rogersmediainc%26channel%3Dzoocasa.com%22%7D%5D%7D"] = true
downloaded["http://www.zoocasa.com/javascripts/routes.js"] = true
downloaded["http://www.zoocasa.com/javascripts/authentication.js"] = true
downloaded["http://assets3.zoocasa.com/assets/common-modern-bd68814ebbdf4d894335dbc9ad870d0f.js"] = true
downloaded["http://assets0.zoocasa.com/assets/common-3b1752ec45db14fb981d2982a8472a8c.js"] = true
downloaded["http://assets3.zoocasa.com/assets/analytics_and_reporting-935dee5e744d77be1f13aeca9fd6b210.js"] = true
downloaded["http://assets1.zoocasa.com/javascripts/real_estate_boards.js"] = true
downloaded["http://assets0.zoocasa.com/assets/site/listings/search/index-fa30de143722896cfc261f13ce0260e5.js"] = true
downloaded["http://assets2.zoocasa.com/assets/application-fe6a2b79760cb6299336e6f309f1dcdb.js"] = true
downloaded["http://www.googleadservices.com/pagead/conversion.js"] = true
downloaded["http://www.googleadservices.com/pagead/conversion/1040794343/?guid=ON&label=vOl8CJ2HgwUQ54Wl8AM&script=0"] = true
downloaded["http://assets3.zoocasa.com/assets/fonts/font-zoocasa-fbd5a0d6abfe2b6b2eeb1d91a3a11b35.woff"] = true
downloaded["http://assets3.zoocasa.com/assets/font-awesome/fontawesome-webfont-8f11ce3a1051e508a844f6b5c2e83955.eot"] = true
downloaded["http://assets3.zoocasa.com/assets/font-awesome/fontawesome-webfont.eot?"] = true
downloaded["http://assets0.zoocasa.com/assets/font-awesome/fontawesome-webfont-f4e13a4e1983bd8e801a351beadfb054.woff2"] = true
downloaded["http://assets2.zoocasa.com/assets/font-awesome/fontawesome-webfont-0f35a5016aeaf6f1eac47c459d92b87a.woff"] = true
downloaded["http://assets0.zoocasa.com/assets/font-awesome/fontawesome-webfont-f9be34d9d5907e4a1b715d3962ad919d.ttf"] = true
downloaded["http://assets2.zoocasa.com/assets/font-awesome/fontawesome-webfont.svg"] = true
downloaded["http://assets3.zoocasa.com/assets/"] = true
downloaded["http://assets3.zoocasa.com/assets"] = true
downloaded["http://assets3.zoocasa.com/en/assets"] = true
downloaded["http://www.zoocasa.com/en/assets"] = true
downloaded["http://assets3.zoocasa.com/assets/logo_zoocasa_white-77164780ede991c806fd531fd04fb643.png"] = true
downloaded["http://assets1.zoocasa.com/assets/logo_zoocasa_white@2x-87241a6b753c664a4940e993bd30e0e0.png"] = true
downloaded["http://assets0.zoocasa.com/assets/common/error-icon-white-4d98adde72d1df3baaba022509c89853.png"] = true
downloaded["http://assets0.zoocasa.com/assets/common/error-icon-white@2x-c6909a5761e2cdcaa2f7fbdebb7c325e.png"] = true
downloaded["http://assets1.zoocasa.com/assets/site/my_accounts/image_savedsearch_empty-5a37de731124bcda71c8bf1c65389fc2.png"] = true
downloaded["http://assets2.zoocasa.com/assets/site/my_accounts/image_savedsearch_empty@2x-e939f2fc383b2b6fb41a9086ed26e2f9.png"] = true
downloaded["http://assets0.zoocasa.com/assets/site/my_accounts/image_savedlisting_empty-f735127da70b4f97d800245452488150.png"] = true
downloaded["http://assets0.zoocasa.com/assets/site/my_accounts/image_savedlisting_empty@2x-6d2c157206eb479fc62a68e1c3a5bab2.png"] = true
downloaded["http://assets2.zoocasa.com/assets/site/home/cta/graphic_appraisal_lrg-a57c80aab20562007f8301771a6f4f87.png"] = true
downloaded["http://assets3.zoocasa.com/assets/site/home/cta/graphic_appraisal_lrg@2x-07dd4426839643625a217817ae45fe71.png"] = true
downloaded["http://assets1.zoocasa.com/assets/agents/icon-choose-agent-5b19830bfb5f1c3fd5c91b2b5e06ad59.png"] = true
downloaded["http://assets0.zoocasa.com/assets/agents/icon-choose-agent@2x-d92211a951eec84817a7d1254b9f88d3.png"] = true
downloaded["http://assets0.zoocasa.com/assets/agents/icon-choose-agent-listing-50e6dbfbdacd5b23f0598d0aecef01c5.png"] = true
downloaded["http://assets3.zoocasa.com/assets/agents/icon-choose-agent-listing@2x-0b5048a7cfad970bb82d54eb170ff481.png"] = true
downloaded["http://assets0.zoocasa.com/assets/common/icons/bt_updown_plus_on-92bbf80623cb4bd0b7f765e64256c8af.png"] = true
downloaded["http://assets3.zoocasa.com/assets/common/icons/bt_updown_plus_on@2x-5cd2129c82fd99a4f7793cbf518b6d39.png"] = true
downloaded["http://assets0.zoocasa.com/assets/common/icons/bt_updown_plus_off-cdc53724ec4687a32da7c60aa0ac4c6c.png"] = true
downloaded["http://assets2.zoocasa.com/assets/common/icons/bt_updown_plus_off@2x-617fade23003b3b36f5d80888bc602f1.png"] = true
downloaded["http://assets3.zoocasa.com/assets/common/icons/bt_updown_minus_on-8713eb7cbc43cb64df3303ddbcb2dbef.png"] = true
downloaded["http://assets1.zoocasa.com/assets/common/icons/bt_updown_minus_on@2x-ece0fb1516382f8bbba4e44d6f833973.png"] = true
downloaded["http://assets0.zoocasa.com/assets/common/icons/bt_updown_minus_off-fd138ee780bebfa0b2987571e67dc1d0.png"] = true
downloaded["http://assets3.zoocasa.com/assets/common/icons/bt_updown_minus_off@2x-7c6d081a3315480b840656db3f4b4e12.png"] = true
downloaded["http://assets3.zoocasa.com/assets/common/loader-b7600145e710b56eb42a12ea02ae5308.gif"] = true
downloaded["http://assets1.zoocasa.com/assets/common/graphic_rebate_tick-435fbc922e17dd51e1e2d71eb4f32dc5.png"] = true
downloaded["http://assets0.zoocasa.com/assets/common/graphic_rebate_tick@2x-d2ec8e18fb917be8595fa36b7acfb886.png"] = true
downloaded["http://assets0.zoocasa.com/assets/common/graphic_new_tab-fd6f6bfa82cee2f06ae00eb3d4b30a85.png"] = true
downloaded["http://assets2.zoocasa.com/assets/common/graphic_new_tab@2x-54405ee3c818f02f4824e4ecea2e8c70.png"] = true
downloaded["http://assets0.zoocasa.com/assets/common/app/android_icon-9e1f352d4c1c14d55eed988e4cd8b1be.png"] = true
downloaded["http://assets3.zoocasa.com/assets/common/pagination-arrow-left-c2ef9dbb46442ac9614f192f8e5f307a.png"] = true
downloaded["http://assets0.zoocasa.com/assets/common/pagination-arrow-left@2x-b79c99ace7cd78c95d3f2a2b1ff99027.png"] = true
downloaded["http://assets1.zoocasa.com/assets/common/pagination-arrow-left-hover-95372b7073690acc46de16f6982abdf5.png"] = true
downloaded["http://assets3.zoocasa.com/assets/common/pagination-arrow-left-hover@2x-dc0440632bd8bbefb8b3048de512a826.png"] = true
downloaded["http://assets2.zoocasa.com/assets/common/pagination-arrow-right-b09ae5bbd86572fb516ce3773835c310.png"] = true
downloaded["http://assets0.zoocasa.com/assets/common/pagination-arrow-right@2x-daacfd51d1a5bfb4076349a6e103c53b.png"] = true
downloaded["http://assets1.zoocasa.com/assets/common/pagination-arrow-right-hover-da50b01385a369650371c11875cbe835.png"] = true
downloaded["http://assets1.zoocasa.com/assets/common/pagination-arrow-right-hover@2x-1f2d681a4e8ef316ffa6e252a1b59564.png"] = true
downloaded["http://assets1.zoocasa.com/assets/common/progress-0972b066889b2bc652d718c9be233e5c.gif"] = true
downloaded["http://assets0.zoocasa.com/assets/common/icons/icon_home_on-4a6e9eff8852319e06a19349b209608a.png"] = true
downloaded["http://assets0.zoocasa.com/assets/common/icons/icon_home_on@2x-dcd9c8f4ce2d5c8eec164834bc29db0f.png"] = true
downloaded["http://assets2.zoocasa.com/assets/common/icons/icon_condo_on-c50b3fdef5b8404eacc0f268b8c2ea41.png"] = true
downloaded["http://assets3.zoocasa.com/assets/common/icons/icon_condo_on@2x-e5701d0dec989c73550c4e34a6a7b154.png"] = true
downloaded["http://assets3.zoocasa.com/assets/bx_loader-2eba456ab8335b1279a2665c39c3eb4d.gif"] = true
downloaded["http://assets1.zoocasa.com/assets/controls-fbb799eee1093f952ad9e28ffa48669c.png"] = true
downloaded["http://assets0.zoocasa.com/assets/site/listings/images/controls.png"] = true
downloaded["http://assets0.zoocasa.com/en/assets/site/listings/images/controls.png"] = true
downloaded["http://www.zoocasa.com/en/assets/site/listings/images/controls.png"] = true
downloaded["http://assets1.zoocasa.com/assets/common/icons/icon_openhouse-1723dd6262ba6410eed8f404a219c962.png"] = true
downloaded["http://assets3.zoocasa.com/assets/common/icons/icon_openhouse@2x-9d527b245b08f9a65408240234be39b2.png"] = true
downloaded["http://assets1.zoocasa.com/assets/common/arrow_left-ed56662a534f3d8ecf8b08b87f7ccf61.png"] = true
downloaded["http://assets3.zoocasa.com/assets/common/arrow_left@2x-afd4f0000fd21e35c2115ed13120d900.png"] = true
downloaded["http://assets0.zoocasa.com/assets/common/arrow_right-75b28d38624497d677b25662e8d95d0c.png"] = true
downloaded["http://assets2.zoocasa.com/assets/common/arrow_right@2x-4f375155c25f2545ef956966cec5c06c.png"] = true
downloaded["http://assets1.zoocasa.com/assets/site/listings/expired-049e664d270cac1aa2371d3a93486d65.css"] = true

read_file = function(file)
  if file then
    local f = assert(io.open(file))
    local data = f:read("*all")
    f:close()
    return data
  else
    return ""
  end
end

wget.callbacks.download_child_p = function(urlpos, parent, depth, start_url_parsed, iri, verdict, reason)
  local url = urlpos["url"]["url"]
  local html = urlpos["link_expect_html"]
  local itemvalue = string.gsub(item_value, "%-", "%%%-")
  
  if downloaded[url] == true or addedtolist[url] == true then
    return false
  end
  
  if (downloaded[url] ~= true or addedtolist[url] ~= true) then
    if string.match(url, itemvalue) or html == 0 then
      addedtolist[url] = true
      return true
    else
      return false
    end
  end
end


wget.callbacks.get_urls = function(file, url, is_css, iri)
  local urls = {}
  local html = nil
  local itemvalue = string.gsub(item_value, "%-", "%%%-")

  if downloaded[url] ~= true then
    downloaded[url] = true
  end
 
  local function check(url)
    if (downloaded[url] ~= true and addedtolist[url] ~= true) then
      if string.match(url, "&amp;") then
        table.insert(urls, { url=string.gsub(url, "&amp;", "&") })
        addedtolist[url] = true
        addedtolist[string.gsub(url, "&amp;", "&")] = true
      else
        table.insert(urls, { url=url })
        addedtolist[url] = true
      end
    end
  end
  
  if string.match(url, item_value) then
    html = read_file(file)
    for newurl in string.gmatch(html, '"(https?://[^"]+)"') do
      if string.match(newurl, itemvalue) then
        check(newurl)
      end
    end
    for newurl in string.gmatch(html, '("/[^"]+)"') do
      if string.match(newurl, itemvalue) and string.match(newurl, '"//') then
        check(string.gsub(newurl, '"//', 'http://'))
      elseif string.match(newurl, itemvalue) and not string.match(newurl, '"//') then
        check(string.match(url, "(https?://[^/]+)/")..string.match(newurl, '"(/.+)'))
      end
    end
  end
  
  return urls
end
  

wget.callbacks.httploop_result = function(url, err, http_stat)
  -- NEW for 2014: Slightly more verbose messages because people keep
  -- complaining that it's not moving or not working
  status_code = http_stat["statcode"]
  
  url_count = url_count + 1
  io.stdout:write(url_count .. "=" .. status_code .. " " .. url["url"] .. ".  \n")
  io.stdout:flush()

  if (status_code >= 200 and status_code <= 399) then
    if string.match(url.url, "https://") then
      local newurl = string.gsub(url.url, "https://", "http://")
      downloaded[newurl] = true
    else
      downloaded[url.url] = true
    end
  end
  
  if status_code >= 500 or
    (status_code >= 400 and status_code ~= 404 and status_code ~= 403) then

    io.stdout:write("\nServer returned "..http_stat.statcode..". Sleeping.\n")
    io.stdout:flush()

    os.execute("sleep 1")

    tries = tries + 1

    if tries >= 6 then
      io.stdout:write("\nI give up...\n")
      io.stdout:flush()
      tries = 0
      return wget.actions.ABORT
    else
      return wget.actions.CONTINUE
    end
  elseif status_code == 0 then

    io.stdout:write("\nServer returned "..http_stat.statcode..". Sleeping.\n")
    io.stdout:flush()

    os.execute("sleep 10")
    
    tries = tries + 1

    if tries >= 6 then
      io.stdout:write("\nI give up...\n")
      io.stdout:flush()
      tries = 0
      return wget.actions.ABORT
    else
      return wget.actions.CONTINUE
    end
  end

  tries = 0

  local sleep_time = 0

  if sleep_time > 0.001 then
    os.execute("sleep " .. sleep_time)
  end

  return wget.actions.NOTHING
end
