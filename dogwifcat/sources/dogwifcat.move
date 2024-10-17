module dogwifcat::dogwifcat {
    
    use sui::coin;
    use sui::url::{Self, Url};

    public struct DOGWIFCAT has drop {}

    fun init( witness: DOGWIFCAT, ctx: &mut TxContext) {
        // Function interface: public fun create_currency<T: drop>(witness: T, decimals: u8, symbol: vector<u8>, name: vector<u8>, description: vector<u8>, icon_url: option::Option<url::Url>, ctx: &mut tx_context::TxContext): (coin::TreasuryCap<T>, coin::CoinMetadata<T>)
        let (mut treasuryCap, metadata) = coin::create_currency(witness, 9, b"DOGWIFCAT", b"DogWifCat", 
            b"Who said cats and dogs can’t get along? DogWifCat is the ultimate meme coin that unites paws and claws in the wild world of crypto. This token is powered by the energy of two beloved internet favorites—playful pups and mischievous kitties—coming together to bring you double the fun and double the gains. Whether you're team Dog or team Cat, there's room for everyone in this community. HODL tight, because when dogs and cats join forces, there’s no limit to where this coin can go—straight to the moon!", 
            option::some<Url>(url::new_unsafe_from_bytes(b"https://d3hnfqimznafg0.cloudfront.net/image-handler/ts/20200218065624/ri/950/src/images/Article_Images/ImageForArticle_227_15820269818147731.png")), 
            ctx);
        
        let amount = 1000000000000000000;
        let sender = tx_context::sender(ctx);

        coin::mint_and_transfer<DOGWIFCAT>(&mut treasuryCap, amount, sender, ctx);

        transfer::public_freeze_object(metadata);
        
        transfer::public_transfer(treasuryCap, tx_context::sender(ctx))
    }

    public entry fun gosho
    (
        cap: &mut coin::TreasuryCap<DOGWIFCAT>, 
        recipient: address,
        value: u64, 
        ctx: &mut tx_context::TxContext
    )
    {
        let new_coin = coin::mint(cap, value, ctx);
        transfer::public_transfer(new_coin, recipient);
    }

    public entry fun popko
    (
        cap: &mut coin::TreasuryCap<DOGWIFCAT>, 
        coin: coin::Coin<DOGWIFCAT>
    )
    {
        coin::burn(cap, coin);
    }
}