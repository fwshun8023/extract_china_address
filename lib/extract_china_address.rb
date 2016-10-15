##
# 提取文本中的地址信息
require 'json'
require 'gb2260'
module ExtractChinaAddress
  CHINA = '000000' # 全国
  PATTERN = /(\d{2})(\d{2})(\d{2})/

  class << self
    def extract(content)
      # 查找所属省自治区
      ps = provinces
      province = content.match(ps.values.join('|')).to_s
      province_code = ps.key(province)

      cs = cities(province_code)
      city = content.match(cs.values.join('|')).to_s
      # city_code = cs.key(city)

      province.to_s + city.to_s
    end

    def provinces
      gb2260 = GB2260.new
      gb2260.provinces.collect {|p| [p.code, p.name.gsub(/[省市(自治区)]/, '')]}.to_h
    end

    def cities(province_code = nil)
      gb2260 = GB2260.new
      cities = []
      unless province_code.nil?
        cities = gb2260.prefectures(province_code)
      else
        gb2260.provinces.each do |province|                                                
          gb_cities = gb2260.prefectures(province.code)
          gb_cities.each do |city| 
            gb_districts = gb2260.counties(city.code)
            gb_districts << GB2260::Division.new("#{city.code[0,4]}99", city.name) if gb_districts.empty?    # 中山市等没有县级，需要自动补上
            cities += gb_districts
          end

          cities += gb_cities
        end
      end
      cities.collect {|c| [c.code, c.name.gsub(/[市(市辖区)县区]/, '')]}.select{|c| c[1].length > 1}.to_h
    end
    
  end
end
