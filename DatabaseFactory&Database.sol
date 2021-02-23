// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes calldata) {
        this; // silence state mutability warning without generating bytecode - see https://github.com/ethereum/solidity/issues/2691
        return msg.data;
    }
}

abstract contract Ownable is Context {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor () {
        address msgSender = _msgSender();
        _owner = msgSender;
        emit OwnershipTransferred(address(0), msgSender);
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view virtual returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(owner() == _msgSender(), "Ownable: caller is not the owner");
        _;
    }

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions anymore. Can only be called by the current owner.
     *
     * NOTE: Renouncing ownership will leave the contract without an owner,
     * thereby removing any functionality that is only available to the owner.
     */
    function renounceOwnership() public virtual onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }
}

library SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function tryAdd(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            uint256 c = a + b;
            if (c < a) return (false, 0);
            return (true, c);
        }
    }

    /**
     * @dev Returns the substraction of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function trySub(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            if (b > a) return (false, 0);
            return (true, a - b);
        }
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function tryMul(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
            // benefit is lost if 'b' is also tested.
            // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
            if (a == 0) return (true, 0);
            uint256 c = a * b;
            if (c / a != b) return (false, 0);
            return (true, c);
        }
    }

    /**
     * @dev Returns the division of two unsigned integers, with a division by zero flag.
     *
     * _Available since v3.4._
     */
    function tryDiv(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            if (b == 0) return (false, 0);
            return (true, a / b);
        }
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers, with a division by zero flag.
     *
     * _Available since v3.4._
     */
    function tryMod(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            if (b == 0) return (false, 0);
            return (true, a % b);
        }
    }

    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     *
     * - Addition cannot overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        return a + b;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return a - b;
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `*` operator.
     *
     * Requirements:
     *
     * - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        return a * b;
    }

    /**
     * @dev Returns the integer division of two unsigned integers, reverting on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator.
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return a / b;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * reverting when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return a % b;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
     * overflow (when the result is negative).
     *
     * CAUTION: This function is deprecated because it requires allocating memory for the error
     * message unnecessarily. For custom revert reasons use {trySub}.
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        unchecked {
            require(b <= a, errorMessage);
            return a - b;
        }
    }

    /**
     * @dev Returns the integer division of two unsigned integers, reverting with custom message on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        unchecked {
            require(b > 0, errorMessage);
            return a / b;
        }
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * reverting with custom message when dividing by zero.
     *
     * CAUTION: This function is deprecated because it requires allocating memory for the error
     * message unnecessarily. For custom revert reasons use {tryMod}.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        unchecked {
            require(b > 0, errorMessage);
            return a % b;
        }
    }
}

interface IERC20 {
    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `recipient`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address recipient, uint256 amount) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @dev Moves `amount` tokens from `sender` to `recipient` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

contract ERC20 is Context, IERC20 {
    mapping (address => uint256) private _balances;

    mapping (address => mapping (address => uint256)) private _allowances;

    uint256 private _totalSupply;

    string private _name;
    string private _symbol;

    /**
     * @dev Sets the values for {name} and {symbol}.
     *
     * The defaut value of {decimals} is 18. To select a different value for
     * {decimals} you should overload it.
     *
     * All three of these values are immutable: they can only be set once during
     * construction.
     */
    constructor (string memory name_, string memory symbol_) {
        _name = name_;
        _symbol = symbol_;
    }

    /**
     * @dev Returns the name of the token.
     */
    function name() public view virtual returns (string memory) {
        return _name;
    }

    /**
     * @dev Returns the symbol of the token, usually a shorter version of the
     * name.
     */
    function symbol() public view virtual returns (string memory) {
        return _symbol;
    }

    /**
     * @dev Returns the number of decimals used to get its user representation.
     * For example, if `decimals` equals `2`, a balance of `505` tokens should
     * be displayed to a user as `5,05` (`505 / 10 ** 2`).
     *
     * Tokens usually opt for a value of 18, imitating the relationship between
     * Ether and Wei. This is the value {ERC20} uses, unless this function is
     * overloaded;
     *
     * NOTE: This information is only used for _display_ purposes: it in
     * no way affects any of the arithmetic of the contract, including
     * {IERC20-balanceOf} and {IERC20-transfer}.
     */
    function decimals() public view virtual returns (uint8) {
        return 18;
    }

    /**
     * @dev See {IERC20-totalSupply}.
     */
    function totalSupply() public view virtual override returns (uint256) {
        return _totalSupply;
    }

    /**
     * @dev See {IERC20-balanceOf}.
     */
    function balanceOf(address account) public view virtual override returns (uint256) {
        return _balances[account];
    }

    /**
     * @dev See {IERC20-transfer}.
     *
     * Requirements:
     *
     * - `recipient` cannot be the zero address.
     * - the caller must have a balance of at least `amount`.
     */
    function transfer(address recipient, uint256 amount) public virtual override returns (bool) {
        _transfer(_msgSender(), recipient, amount);
        return true;
    }

    /**
     * @dev See {IERC20-allowance}.
     */
    function allowance(address owner, address spender) public view virtual override returns (uint256) {
        return _allowances[owner][spender];
    }

    /**
     * @dev See {IERC20-approve}.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     */
    function approve(address spender, uint256 amount) public virtual override returns (bool) {
        _approve(_msgSender(), spender, amount);
        return true;
    }

    /**
     * @dev See {IERC20-transferFrom}.
     *
     * Emits an {Approval} event indicating the updated allowance. This is not
     * required by the EIP. See the note at the beginning of {ERC20}.
     *
     * Requirements:
     *
     * - `sender` and `recipient` cannot be the zero address.
     * - `sender` must have a balance of at least `amount`.
     * - the caller must have allowance for ``sender``'s tokens of at least
     * `amount`.
     */
    function transferFrom(address sender, address recipient, uint256 amount) public virtual override returns (bool) {
        _transfer(sender, recipient, amount);

        uint256 currentAllowance = _allowances[sender][_msgSender()];
        require(currentAllowance >= amount, "ERC20: transfer amount exceeds allowance");
        _approve(sender, _msgSender(), currentAllowance - amount);

        return true;
    }

    /**
     * @dev Atomically increases the allowance granted to `spender` by the caller.
     *
     * This is an alternative to {approve} that can be used as a mitigation for
     * problems described in {IERC20-approve}.
     *
     * Emits an {Approval} event indicating the updated allowance.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     */
    function increaseAllowance(address spender, uint256 addedValue) public virtual returns (bool) {
        _approve(_msgSender(), spender, _allowances[_msgSender()][spender] + addedValue);
        return true;
    }

    /**
     * @dev Atomically decreases the allowance granted to `spender` by the caller.
     *
     * This is an alternative to {approve} that can be used as a mitigation for
     * problems described in {IERC20-approve}.
     *
     * Emits an {Approval} event indicating the updated allowance.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     * - `spender` must have allowance for the caller of at least
     * `subtractedValue`.
     */
    function decreaseAllowance(address spender, uint256 subtractedValue) public virtual returns (bool) {
        uint256 currentAllowance = _allowances[_msgSender()][spender];
        require(currentAllowance >= subtractedValue, "ERC20: decreased allowance below zero");
        _approve(_msgSender(), spender, currentAllowance - subtractedValue);

        return true;
    }

    /**
     * @dev Moves tokens `amount` from `sender` to `recipient`.
     *
     * This is internal function is equivalent to {transfer}, and can be used to
     * e.g. implement automatic token fees, slashing mechanisms, etc.
     *
     * Emits a {Transfer} event.
     *
     * Requirements:
     *
     * - `sender` cannot be the zero address.
     * - `recipient` cannot be the zero address.
     * - `sender` must have a balance of at least `amount`.
     */
    function _transfer(address sender, address recipient, uint256 amount) internal virtual {
        require(sender != address(0), "ERC20: transfer from the zero address");
        require(recipient != address(0), "ERC20: transfer to the zero address");

        _beforeTokenTransfer(sender, recipient, amount);

        uint256 senderBalance = _balances[sender];
        require(senderBalance >= amount, "ERC20: transfer amount exceeds balance");
        _balances[sender] = senderBalance - amount;
        _balances[recipient] += amount;

        emit Transfer(sender, recipient, amount);
    }

    /** @dev Creates `amount` tokens and assigns them to `account`, increasing
     * the total supply.
     *
     * Emits a {Transfer} event with `from` set to the zero address.
     *
     * Requirements:
     *
     * - `to` cannot be the zero address.
     */
    function _mint(address account, uint256 amount) internal virtual {
        require(account != address(0), "ERC20: mint to the zero address");

        _beforeTokenTransfer(address(0), account, amount);

        _totalSupply += amount;
        _balances[account] += amount;
        emit Transfer(address(0), account, amount);
    }

    /**
     * @dev Destroys `amount` tokens from `account`, reducing the
     * total supply.
     *
     * Emits a {Transfer} event with `to` set to the zero address.
     *
     * Requirements:
     *
     * - `account` cannot be the zero address.
     * - `account` must have at least `amount` tokens.
     */
    function _burn(address account, uint256 amount) internal virtual {
        require(account != address(0), "ERC20: burn from the zero address");

        _beforeTokenTransfer(account, address(0), amount);

        uint256 accountBalance = _balances[account];
        require(accountBalance >= amount, "ERC20: burn amount exceeds balance");
        _balances[account] = accountBalance - amount;
        _totalSupply -= amount;

        emit Transfer(account, address(0), amount);
    }

    /**
     * @dev Sets `amount` as the allowance of `spender` over the `owner` s tokens.
     *
     * This internal function is equivalent to `approve`, and can be used to
     * e.g. set automatic allowances for certain subsystems, etc.
     *
     * Emits an {Approval} event.
     *
     * Requirements:
     *
     * - `owner` cannot be the zero address.
     * - `spender` cannot be the zero address.
     */
    function _approve(address owner, address spender, uint256 amount) internal virtual {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");

        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }

    /**
     * @dev Hook that is called before any transfer of tokens. This includes
     * minting and burning.
     *
     * Calling conditions:
     *
     * - when `from` and `to` are both non-zero, `amount` of ``from``'s tokens
     * will be to transferred to `to`.
     * - when `from` is zero, `amount` tokens will be minted for `to`.
     * - when `to` is zero, `amount` of ``from``'s tokens will be burned.
     * - `from` and `to` are never both zero.
     *
     * To learn more about hooks, head to xref:ROOT:extending-contracts.adoc#using-hooks[Using Hooks].
     */
    function _beforeTokenTransfer(address from, address to, uint256 amount) internal virtual { }
}

interface Persistance {
    // Enum types
    enum ColumnType { Int, Usigned, String, Double, Date, Datetime, Boolean }

    // Persistance data structures
    struct Column {
        ColumnType columnType;
        bytes32 name;
    }
    struct Table {
        uint256 currentIndex;
        Column[] columns;
        string[][] rows;
    }

    // Core data structures
    struct SchemaEntry {
        uint256 index;
        bytes32 name;
    }
    struct TableEntry {
        uint256 index;
        bytes32 name;
        Table data;
    }
}

contract Database is Persistance, Ownable {
    /** @dev SafeMath library */
    using SafeMath for uint256;

    // Persistant data
    Persistance.TableEntry[] private tables;
    mapping(uint256 => bool) private knownTables;
    mapping(bytes32 => bool) private knownTableNames;

    // Utility
    uint256 private currentTableIndex;

    // Factory and pricing
    DatabaseFactory public factory;

    constructor(address factoryAddress, address creatorAddress) public {
        factory = DatabaseFactory(factoryAddress);
        
        transferOwnership(creatorAddress);
    }

    /**
     * Equivalent of `show tables;` in SQL
     * @return _tables Array of strings. Empty rows must be ignored.
     *    Even indices are tables' identifiers.
     *    Odd indices are tables' names.
     */
    function showTables() external view returns(bytes32[] memory _tables) {
        bytes32[] memory result = new bytes32[](tables.length * 2);

        for (uint i = 0; i < tables.length; i++) {
            if (!knownTables[tables[i].index]) {
                continue;
            }

            result[i * 2] = bytes32(tables[i].index);
            result[i * 2 + 1] = tables[i].name;
        }

        return result;
    }

    /**
     * Equivalent of `create table` in SQL
     * @param _name Table name
     * @param _columns Table columns
     * @return _index Table's identifier
     */
    function createTable(bytes32 _name, bytes32[] calldata _columns) external price(factory.CreateTablePrice()) returns(uint256 _index) {
        require(_name[0] != 0, "Name must not be empty");
        require(_columns.length > 0, "Empty columns array");

        // Check if name is already taken
        require(knownTableNames[_name] == false, "Duplicate table name");

        // Insert new table into mapping
        tables.push();
        Persistance.TableEntry storage table = tables[tables.length - 1];
        table.name = _name;
        table.index = currentTableIndex;

        // Set into known mapping
        knownTableNames[_name] = true;
        knownTables[currentTableIndex] = true;

        // Insert table's columns defintions
        for (uint i = 0; i < _columns.length; i += 2) {
            table.data.columns.push(Persistance.Column({
                columnType: Persistance.ColumnType(uint(_columns[i])),
                name: _columns[i + 1]
            }));
        }

        uint256 tmpIndex = currentTableIndex;

        // Increment counter
        currentTableIndex = currentTableIndex.add(1);

        // Emit event
        emit TableCreated(tmpIndex, _name);

        return tmpIndex;
    }

    function dropTable(uint256 _table) external hasTable(_table) price(factory.DropTablePrice()) {
        TableEntry storage table = tables[_table];

        // Clear storage
        delete tables[_table];
        knownTables[_table] = false;
        knownTableNames[table.name] = false;

        // Emit event
        emit TableDropped(_table);
    }

    function desc(uint256 _table) external view hasTable(_table) returns (bytes32[] memory _columns) {
        bytes32[] memory result = new bytes32[](tables[_table].data.columns.length * 2);

        for (uint i = 0; i < tables[_table].data.columns.length; i++) {
            result[i * 2] = bytes32(uint(tables[_table].data.columns[i].columnType));
            result[i * 2 + 1] = tables[_table].data.columns[i].name;
        }

        return result;
    }

    function insert(uint256 _table, string[] calldata _values) external
        hasTable(_table)
        price(factory.InsertIntoPrice())
        returns(uint256 _index)
    {
        // Create an empty row
        tables[_table].data.rows.push();
        uint256 latestIndex = tables[_table].data.rows.length - 1;

        /**
         * @dev we need to iterate the array because of a bug in the compiler
         * @todo Switch to a direct assignment once ABIEncoderV2 is stable
         */
        for (uint i = 0; i < _values.length; i++) {
            tables[_table].data.rows[latestIndex].push(_values[i]);
        }

        // Emit event
        emit RowCreated(latestIndex);

        return latestIndex;
    }

    function deleteDirect(uint256 _table, uint256 _index) external hasTable(_table) price(factory.DeleteFromPrice()) {
        // Clear storage
        delete tables[_table].data.rows[_index];

        // Emit event
        emit RowDeleted(_index);
    }

    function updateDirect(uint256 _table, uint256 _index, uint256[] calldata _columns, string[] calldata _values) external
        hasTable(_table)
        price(factory.UpdatePrice())
    {
        require(_columns.length == _values.length, "Columns and values arrays must be of equal length");

        string[] storage row = tables[_table].data.rows[_index];
        for (uint i = 0; i < _columns.length; i++) {
            row[_columns[i]] = _values[i];
        }

        emit RowUpdated(_index);
    }

    function selectAll(uint256 _table, uint256 _offset, uint256 _limit) external view
        hasTable(_table)
        returns (string[][] memory _rows)
    {
        require(_offset >= 0, "Offset must be a positive integer or zero");
        require(_limit >= 0 && _limit <= 50, "Limit must be between 0 and 50");
        require(_offset < tables[_table].data.rows.length, "Offset must be smaller that the number of rows");

        uint256 upper = _offset.add(_limit);
        uint256 limit = tables[_table].data.rows.length < upper ? tables[_table].data.rows.length : upper;

        string[][] memory rows = new string[][](limit);

        for (uint i = _offset; i < limit; i++) {
            rows[i.sub(_offset)] = tables[_table].data.rows[i];
        }

        return rows;
    }

    function rowsCount(uint256 _table) external view hasTable(_table) returns (uint256 _count) {
        return tables[_table].data.rows.length;
    }

    function _purchase(address _from, uint256 _price) internal {
        ERC20 token = ERC20(factory.EMTV_TOKEN_ADDRESS());

        bool result = token.transferFrom(_from, address(factory), _price);

        require(result, "Transfer returned false");
    }

    modifier hasTable(uint256 _table) {
        require(knownTables[_table] == true, "Table does not exist");
        _;
    }

    modifier price(uint256 _price) {
        require(factory.canPurchase(msg.sender, _price), "Not enough eMTV to proceed with the transaction");

        _purchase(msg.sender, _price);

        _;
    }

    event TableCreated(uint256 index, bytes32 name);
    event TableDropped(uint256 index);
    event RowCreated(uint256 index);
    event RowDeleted(uint256 index);
    event RowUpdated(uint256 index);
}

contract DatabaseFactory is Ownable {
    /** @dev SafeMath library */
    using SafeMath for uint256;

    /** @dev eMTV token address */
    address public EMTV_TOKEN_ADDRESS = 0x3dE3b94BC275a355f2002c7298919228d7E0eD35;

    /** @dev Action prices */
    uint256 public UpdatePrice = 1 ether;
    uint256 public DropTablePrice = 1 ether;
    uint256 public InsertIntoPrice = 1 ether;
    uint256 public DeleteFromPrice = 1 ether;
    uint256 public CreateTablePrice = 1 ether;
    uint256 public CreateDatabasePrice = 1 ether;

    /**
     * @dev Created databases
     */
    mapping(address => address[]) public databaseAddresses;
    mapping(address => bytes32[]) public databaseNames;

    /**
     * @dev Used to check for duplicated databases' names
     */
    mapping(address => mapping(bytes32 => bool)) private databaseUsedNames;

    /**
     * @dev Returns the databases owned by the requested address
     * @return _addresses The database addresses list
     * @return _names The database names list
     */
    function databases(address _owner) view external returns (address[] memory _addresses, bytes32[] memory _names) {
        return (databaseAddresses[_owner], databaseNames[_owner]);
    }

    /**
     * @dev Creates a new database instance
     * @return _database The newly created contract
     */
    function create(bytes32 _name) external returns (address _database) {
        return _create(_name, msg.sender);
    }

    /**
     * @dev Creates a new database instance using tokens from another account
     * @return _database The newly created contract
     */
    function createFrom(bytes32 _name, address _from) external returns (address _database) {
        return _create(_name, _from);
    }

    /**
     * @dev Withdraws all eMTVs to an address
     */
    function withdraw(address _to) external onlyOwner {
        ERC20 token = ERC20(EMTV_TOKEN_ADDRESS);

        token.transfer(_to, token.balanceOf(address(this)));
    }

    /**
     * @dev Updates the price to update a row
     */
    function updateUpdatePrice(uint256 _newPrice) external onlyOwner {
        UpdatePrice = _newPrice;

        emit UpdatePriceUpdated(_newPrice);
    }

    /**
     * @dev Updates the price to drop a table
     */
    function updateDropTablePrice(uint256 _newPrice) external onlyOwner {
        DropTablePrice = _newPrice;

        emit DropTablePriceUpdated(_newPrice);
    }

    /**
     * @dev Updates the price to insert a row
     */
    function updateInsertIntoPrice(uint256 _newPrice) external onlyOwner {
        InsertIntoPrice = _newPrice;

        emit InsertIntoPriceUpdated(_newPrice);
    }

    /**
     * @dev Updates the price to delete a row
     */
    function updateDeleteFromPrice(uint256 _newPrice) external onlyOwner {
        DeleteFromPrice = _newPrice;

        emit DeleteFromPriceUpdated(_newPrice);
    }

    /**
     * @dev Updates the price to delete a row
     */
    function updateCreateTablePrice(uint256 _newPrice) external onlyOwner {
        CreateTablePrice = _newPrice;

        emit CreateTablePriceUpdated(_newPrice);
    }

    /**
     * @dev Updates the price to create a new Database
     */
    function updateCreateDatabasePrice(uint256 _newPrice) external onlyOwner {
        CreateDatabasePrice = _newPrice;

        emit CreateDatabasePriceUpdated(_newPrice);
    }

    /**
     * @dev Update the token address. This is here only for debugging porpuses!
     */
    function updateTokenAddress(address _newAddress) external onlyOwner {
        EMTV_TOKEN_ADDRESS = _newAddress;

        emit TokenAddressUpdated(_newAddress);
    }

    /**
     * @dev Checks if an address can make a purchase
     */
    function canPurchase(address _from, uint256 _price) public view returns (bool _canPurchase) {
        ERC20 token = ERC20(EMTV_TOKEN_ADDRESS);
        uint256 balance = token.balanceOf(_from);

        return balance.sub(_price) >= 0;
    }

    function _create(bytes32 _name, address _from) internal returns (address _database) {
        require(_name.length > 0, "A database must have a name");
        require(_from != address(0x0), "Invalid owner address");
        require(databaseUsedNames[_from][_name] == false, "Duplicate database name");

        ERC20 token = ERC20(EMTV_TOKEN_ADDRESS);
        uint256 balance = token.balanceOf(_from);

        require(balance.sub(CreateDatabasePrice) >= 0, "Not enough tokens to create a new database");

        bool result = token.transferFrom(_from, address(this), CreateDatabasePrice);

        require(result, "Transfer returned false");

        Database db = new Database(address(this), _from);
        address dbAddress = address(db);

        databaseUsedNames[_from][_name] = true;

        databaseNames[_from].push(_name);
        databaseAddresses[_from].push(dbAddress);

        emit DatabaseCreated(_name, _from, address(db));

        return address(db);
    }

    event DatabaseCreated(bytes32 _name, address _by, address _contract);
    event TokenAddressUpdated(address _newAddress);

    event UpdatePriceUpdated(uint256 _newPrice);
    event DropTablePriceUpdated(uint256 _newPrice);
    event InsertIntoPriceUpdated(uint256 _newPrice);
    event DeleteFromPriceUpdated(uint256 _newPrice);
    event CreateTablePriceUpdated(uint256 _newPrice);
    event CreateDatabasePriceUpdated(uint256 _newPrice);
}
