const {assert} = require('chai') 

const KryptoBird = artifacts.require('./KryptoBird')

//check for chai

require('chai')
.use(require('chai-as-promised'))
.should()

contract('KryptoBird', (accounts) => {
    let contract
    //before tell us test to run thiis first before anything
    before( async () =>{
    contract = await KryptoBird.deployed()
    })
    //testing container - describe
    describe('address', async() => {
        //test samples with
        it('deploys successfuly', async() =>{
            const address = await contract.address
            assert.notEqual(address, '')
            assert.notEqual(address, null)
            assert.notEqual(address, undefined)
            assert.notEqual(address, 0x0)
        })
        it('has name', async() =>{
            const name = await contract.name()
            assert.equal(name, 'KryptoBird')
        })
        it('has symbol', async() =>{
            const symbol = await contract.symbol()
            assert.equal(symbol, 'KBIRDZ')
        })
    })  
    describe('minting', async() =>{
        it('create a new token', async () =>{
            const result = await contract.mint('1')
            const totalSupply = await contract.totalSupply()
            //成功
            assert.equal(totalSupply, '1')
            const event = result.logs[0].args
            assert.equal(event._from, '0x0000000000000000000000000000000000000000', 'from is 0 address')
            assert.equal(event._to, accounts[0], 'to is msg.sender')
            //失敗
            await contract.mint('1').should.be.rejected
        })
    })
    describe('indexing', async() => {
        it('list birdz', async() => {
            await contract.mint('2')
            await contract.mint('3')
            await contract.mint('4')
            const totalSupply = await contract.totalSupply()
        
            let result = []
            let KryptoBird,i
            for(i = 1; i <= totalSupply; i++){
                KryptoBird = await contract.kryptoBird(i-1)
                result.push(KryptoBird)
                
            }
            let expect = ['1', '2', '3', '4']
            assert.equal(result.join(','), expect.join(','))
        })
    })
})