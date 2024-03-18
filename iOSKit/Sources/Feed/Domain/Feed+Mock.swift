import Foundation
import Tools

extension Feed {
	static var mock: Self {
		let json = """
		  {
			"banners": [
			  {
				"id": 1,
				"title": "CLAREIA10",
				"subtitle": "10% de desconto",
				"description": "Cupom disponível para todos os nossos produtos",
				"image": null
			  },
			  {
				"id": 2,
				"title": "FRETE GRÁTIS",
				"subtitle": "Região Nordeste",
				"description": "Para o restante do Brasil a partir de R$399 em compras",
				"image": null
			  }
			],
			"categories": [
			  {
				"type": "highlight",
				"name": "Destaque",
				"products": [
				  {
					"id": 1,
					"name": "Kimono Granada",
					"description": "",
					"price": 260.9,
					"promotional_price": null,
					"photos": [
					  "https://i.postimg.cc/ncVbfwmj/Copy-of-CLAREAMOR-50-batcheditor-fotor.jpg",
					  "https://i.postimg.cc/W42zxPVD/Copy-of-CLAREAMOR-65-batcheditor-fotor.jpg",
					  "https://i.postimg.cc/28VKFqBy/Copy-of-CLAREAMOR-58-batcheditor-fotor.jpg"
					],
					"colors": [
					  {
						"id": 1,
						"name": "white",
						"rgb": "#FFFFFF"
					  }
					],
					"sizes": [
					  "small",
					  "medium",
					  "large",
					  "extraLarge"
					]
				  }
				]
			  }
			]
		  }
		"""
		return JSONDecoder.shared.decode(Self.self, string: json)!
	}
}
