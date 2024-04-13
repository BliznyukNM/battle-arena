###############################################################################
##
## LOBBY DATABASE MANAGER
## 
## This script is used to:
## 1. Create a new table in the remote database. This can be run from the W4 tab,
##    by selecting the file and pressing "run"
## 2. Define a `Profile` class, used by the mapper, but which is also referenced
##    in other parts of this project
##

############################### ORM SETUP #####################################

const W4RMMapper := preload("res://addons/w4gd/w4rm/w4rm_mapper.gd")

## Appends custom types and tables to the mapper so it can be used throughout
## the application. Run this once before using any database call.
static func setup_mapper(mapper: W4RMMapper) -> void:
    mapper.add_table("Profile", Profile)
    mapper.done()


## Creates the table on W4 cloud's database.
##
## Run this function once through the W4 dock in the Godot editor to create a 
## table on the remote W4 database. Tt ensures all tables in the mapper get 
## created.
## If the table already exists, it will be dropped first and recreated from
## scratch.
static func run_static(sdk: W4Client) -> void:
    setup_mapper(sdk.mapper)
    # var okay = await sdk.mapper.init_db({"create": false, "drop_data": true, "cascade": true})
    var okay = await sdk.mapper.init_db()
    print("Created DB: %s" % okay)


######################### DATABASE HELPERS ####################################


## Returns a username for a given user id
##
## Returns the given default if the player was not found
static func get_profile(id: String) -> Profile:
    return await W4GD.mapper.get_by_id(Profile, id)


## Sets or creates a new profile in the database
##
## If there was no profile associated with the currently logged in user, this 
## will create a new one.
## If a profile existed, this will update the username.
## If the username is unchanged from previously, nothing will happen.
static func set_own_username(new_username: String) -> void:
    if new_username.is_empty(): return
    
    var profile: Profile = await W4GD.mapper.get_by_id(Profile, W4GD.get_identity().get_uid())
    if profile == null:
        profile = Profile.new()
        profile.username = new_username
        await W4GD.mapper.create(profile)
    elif profile.username != new_username:
        profile.username = new_username
        await W4GD.mapper.update(profile)


static func set_own_profile_picture(picture_url: String) -> void:
    if picture_url.is_empty(): return
    
    var profile: Profile = await get_profile(W4GD.get_identity().get_uid())
    if profile == null:
        profile = Profile.new()
        profile.picture_url = picture_url
        await W4GD.mapper.create(profile)
    elif profile.picture_url != picture_url:
        profile.picture_url = picture_url
        await W4GD.mapper.update(profile)


######################## PROFILE ORM CLASS #####################################


## Represents a player's profile as stored in the database.
class Profile:
    ## A static and unique id for the player. The StringName type gets converted to an index in the SQL database. 
    ## This is a foreign key towards `users.uid`
    var id: StringName
    ## The username entered by the player.
    var username: String
    var picture_url: String

    # Called by the W4 mapper to set specific column options in the SQL database.
    static func _w4rm_type_options(opts: Dictionary) -> void:
        opts["id"] = W4RM.tref("auth.users", {
            default = "auth.uid()",
            external = true,
        })

    # Called by the W4 mapper to set specific column policies.
    static func _w4rm_security_policies(policies: Dictionary) -> void:
        policies["Anyone can view profiles"] = W4RM.build_security_policy_for(['anon', 'authenticated']).can_select();
        policies["User can create own profile"] = W4RM.build_security_policy_for('authenticated').owner_can_insert('id');
        policies["User can update own profile"] = W4RM.build_security_policy_for('authenticated').owner_can_update('id');
