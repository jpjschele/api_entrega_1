module ApplicationHelper
    def open_warehouses
        key = 'NTMFwkt1:e$A&m'
        data = 'GET'
        digest = OpenSSL::Digest.new('sha1')
        hmac = OpenSSL::HMAC.hexdigest(digest, key.encode("ASCII"), data.encode("ASCII"))
        bro = [[hmac].pack("H*")].pack("m0")
        uri = URI.parse("https://integracion-2018-dev.herokuapp.com/bodega/almacenes")
        req = Net::HTTP::Get.new(uri)
        req['Authorization'] = "INTEGRACION grupo9:"+bro
        req['Content-Type'] = "application/json"
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = (uri.scheme == "https")
        res = http.request(req)

        return JSON.parse(res.body)

    end

    def open_products(warehouses)
        key = 'NTMFwkt1:e$A&m'
        dic = {}
        warehouses.each do |warehouse|
            data = 'GET'+warehouse["_id"]
            digest = OpenSSL::Digest.new('sha1')
            hmac = OpenSSL::HMAC.hexdigest(digest, key.encode("ASCII"), data.encode("ASCII"))
            bro = [[hmac].pack("H*")].pack("m0")
            uri = URI.parse("https://integracion-2018-dev.herokuapp.com/bodega/skusWithStock?almacenId="+warehouse["_id"])
            req = Net::HTTP::Get.new(uri)
            req['Authorization'] = "INTEGRACION grupo9:"+bro
            req['Content-Type'] = "application/json"
            http = Net::HTTP.new(uri.host, uri.port)
            http.use_ssl = (uri.scheme == "https")
            res = http.request(req)
            products = JSON.parse(res.body)
            products.each do |product|
                if dic.key?(product["_id"])
                    dic[product["_id"]] += product["total"].to_i
                else
                    dic[product["_id"]] = product["total"].to_i
                end
            end

        end
        output = []
        dic.keys.each do |sku|
            output << {"sku"=> sku, "avaible" => dic[sku]}
        end
        return output
    end


    
end
