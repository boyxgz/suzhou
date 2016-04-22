package com.surelution.utop

class RedirectionController {

    def path(String id) {
		def p = KeyedMessage.findByKey("redirect-to-${id}")?.message
		redirect(url:p)
	}
}
