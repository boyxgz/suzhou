package com.surelution.utop

import grails.util.Holders;

import com.surelution.whistle.push.Menu;

class ImageController {

    def 'name'(Long id) {
		def vf = AliOssFile.get(id)
		
		response.outputStream << AliOssFileHelper.downloadFile(Holders.config.alioss.bucket.name, vf.id.toString())
	}
	
	def productDefaultPicture(Long id) {
		def product = Product.get(id)
		def pp = ProductPicture.findAllByProduct(product).min {
			it.index
		}
		def fileStream
		if(pp && pp.file) {
			fileStream = AliOssFileHelper.downloadFile(Holders.config.alioss.bucket.name, pp.file.id.toString())
		} else {
			fileStream = this.class.getResourceAsStream("no-pic.jpg")
		}
		response.outputStream << fileStream
	}
}
