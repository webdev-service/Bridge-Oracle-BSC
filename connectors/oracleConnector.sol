pragma solidity ^0.5.8;


contract Oracle {
    
    event Log1(address sender, bytes32 cid, uint timestamp, string _datasource, string _arg, uint gaslimit, byte proofType);
    event Log2(address sender, bytes32 cid, uint timestamp, string _datasource, string _arg1, string _arg2, uint gaslimit, byte proofType);
    
    mapping(address => byte) internal addr_proofType;
    mapping (address => uint) internal reqc;




    address private owner;

    constructor() internal {
    	owner = msg.sender;
    }


    modifier onlyAdmin() {
    	require(owner == msg.sender);
    	_;
    }

    function setProofType(byte _proofType) external {
    	addr_proofType[msg.sender] = _proofType;
    }
	
	function withdrawFunds(address _addr) external onlyAdmin {
		_addr.send(this.balance);
	}

	function query(string calldata _datasource, string calldata _arg) external payable returns(bytes32 _id) {
		//set gasLimit tron blockchain
	 	return query1(0, _datasource, _arg, 200000);
    }

    function query(uint _timestamp, string calldata _datasource, string calldata _arg) payable external returns(bytes32 _id) {
    	return query1(_timestamp, _datasource, _arg, 200000);
    }

    function query_withGasLimit(uint _timestamp, string calldata _datasource, string calldata _arg, uint _gaslimit) external payable returns(bytes32 _id) {
    	return query1(_timestamp, _datasource, _arg, _gaslimit);
    }

    function query2(uint _timestamp, string calldata _datasource, string calldata _arg1, string calldata _arg2) external payable returns(bytes32 _id) {
    	return query2(_timestamp, _datasource, _arg1, _arg2, 200000);
    }

    function query2_withGasLimit(uint _timestamp, string calldata _datasource, string calldata _arg1, string calldata _arg2, uint _gasLimit) external payable returns(bytes32 _id) {
    	return query2(_timestamp, _datasource, _arg1, _arg2, _gasLimit);
    }

    function query1(uint _timestamp, string memory _datasource, string memory _arg, uint _gaslimit) public payable returns(bytes32 _id) {
    	reqc[msg.sender]++;
	  	bytes32 customHash = keccak256('keyvan');
	  	emit Log1(msg.sender, customHash, _timestamp, _datasource, _arg, _gaslimit, addr_proofType[msg.sender]);
	  	return customHash;
    }

    function query2(uint _timestamp, string memory _datasource, string memory _arg1, string memory _arg2, uint _gasLimit) public payable returns(bytes32 _id) {
    	reqc[msg.sender]++;
	  	bytes32 customHash = keccak256('keyvan');
	  	emit Log2(msg.sender, customHash, _timestamp, _datasource, _arg1, _arg2, _gasLimit, addr_proofType[msg.sender]);
	  	return customHash;
    }




}