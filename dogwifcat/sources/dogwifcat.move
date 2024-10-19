module dogwifcat::dogwifcat {
    
    use sui::coin;
    use sui::url::{Self, Url};

    public struct DOGWIFCAT has drop {}

    fun init( witness: DOGWIFCAT, ctx: &mut TxContext) {
        
        let icon_url = url::new_unsafe_from_bytes(b"data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/4gHYSUNDX1BST0ZJTEUAAQEAAAHIAAAAAAQwA...");

        let (mut treasuryCap, metadata) = coin::create_currency(
            witness,
            9,
            b"DOGWIFCAT",
            b"DogWifCat", 
            b"Who said cats and dogs can’t get along? DogWifCat is the ultimate meme coin that unites paws and claws in the wild world of crypto. This token is powered by the energy of two beloved internet favorites—playful pups and mischievous kitties—coming together to bring you double the fun and double the gains. Whether you're team Dog or team Cat, there's room for everyone in this community. HODL tight, because when dogs and cats join forces, there’s no limit to where this coin can go—straight to the moon!", 
            option::some(icon_url), 
            ctx);
        
        let amount = 1000000000 * 1000000000;
        let sender = tx_context::sender(ctx);

        coin::mint_and_transfer<DOGWIFCAT>(&mut treasuryCap, amount, sender, ctx);

        transfer::public_freeze_object(metadata);
        
        transfer::public_transfer(treasuryCap, tx_context::sender(ctx))
    }

    public entry fun mint
    (
        cap: &mut coin::TreasuryCap<DOGWIFCAT>, 
        recipient: address,
        value: u64, 
        ctx: &mut tx_context::TxContext
    )
    {
        let amount = value * 1000000000;
        let new_coin = coin::mint(cap, value, ctx);
        transfer::public_transfer(new_coin, recipient);
    }
	
    public entry fun burn
    (
        cap: &mut coin::TreasuryCap<DOGWIFCAT>, 
        coin: coin::Coin<DOGWIFCAT>
    )
    {
        coin::burn(cap, coin);
    }
}