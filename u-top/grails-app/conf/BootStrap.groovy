import com.surelution.locator.BaiduLocator
import com.surelution.locator.Location
import com.surelution.utop.GasStation
import com.surelution.utop.User

class BootStrap {

    def init = { servletContext ->
//		def roleAdmin = Role.findOrCreateByAuthority("ROLE_ADMIN")
//		roleAdmin.save(flush:true)
//		
//		def roleStation = Role.findOrCreateByAuthority("ROLE_STATION")
//		roleStation.save(flush:true)
//		
//		def userAdmin = User.findByUsername("youmiadmin")
//		if(!userAdmin) {
//			userAdmin = new User()
//			userAdmin.username = "youmiadmin"
//			userAdmin.password = "YmLife@1234"
//			userAdmin.enabled = true
//			userAdmin.accountExpired = false
//			userAdmin.accountLocked = false
//			userAdmin.save(flush:true)
//			
//			def ur = new UserRole()
//			ur.user = userAdmin
//			ur.role = roleAdmin
//			ur.save(flush:true)
//		} servletContext ->
		def stations = GasStation.createCriteria().list {
			eq('active', true)
		}
		def locations = stations.collect {station ->
			new Location((int)station.id, (float)station.longitude, (float)station.latitude)
		}
		BaiduLocator.instance.feed(locations)
		
		User admin = User.findByUsername("admin")
		if(!admin) {
			admin = new User(username:"admin", password:"admin", 
				enabled: true, accountExpired: false, accountLocked: false)
			admin.save(flush:true)
		}
    
		
    }

    def destroy = {
    }
}
