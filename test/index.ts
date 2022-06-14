// import { expect } from "chai";
import { ethers } from "hardhat";

describe("Greeter", function () {
  it("Should return the new greeting once it's changed", async function () {
    const [owner, addr1, addr2] = await ethers.getSigners();

    // eslint-disable-next-line node/no-unsupported-features/node-builtins
    console.table([owner.address, addr1.address, addr2.address]);

    const Todo = await ethers.getContractFactory("ToDo");
    const todo = await Todo.deploy(owner.address);
    // 加上connect 可以指定帳號
    // const greeter = await Greeter.connect(addr1).deploy("Hello, world!");
    await todo.deployed();

    let tx = await todo.addToDo("something 1");
    await tx.wait();

    tx = await todo.addToDo("something 2");
    await tx.wait();

    tx = await todo.addToDo("something 3");
    await tx.wait();

    tx = await todo.addToDo("something 4");
    await tx.wait();

    tx = await todo.toggleToDoCompleted(0);
    await tx.wait();

    tx = await todo.deleteToDo(1);
    await tx.wait();

    const list = await todo.todoList();
    // eslint-disable-next-line node/no-unsupported-features/node-builtins
    console.table(list);

    // expect(await greeter.greet()).to.equal("Hello, world!");

    // const setGreetingTx = await greeter
    //   .connect(addr1)
    //   .setGreeting("Hola, mundo!");

    // // wait until the transaction is mined
    // await setGreetingTx.wait();

    // expect(await greeter.greet()).to.equal("Hola, mundo!");
  });
});
