import { DeployFunction } from 'hardhat-deploy/types';


const deployFunction: DeployFunction = async (hre) => {

	const { deployments, getNamedAccounts } = hre;
	const { deploy } = deployments;

	const { deployer } = await getNamedAccounts();

	await deploy('Base64Json', {
		from: deployer,
		log: true,
	});

	await deploy('PureJson', {
		from: deployer,
		log: true,
	});

	await deploy('Base64JsonWithEncodedImage', {
		from: deployer,
		log: true,
	});

	await deploy('PureJsonWithEncodedImage', {
		from: deployer,
		log: true,
	});
};

deployFunction.tags = ['Base64Json', 'PureJson', 'Base64JsonWithEncodedImage', 'PureJsonWithEncodedImage'];

export default deployFunction;
