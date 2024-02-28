import React, { useState, useEffect } from 'react';

function App() {
  const [output, setOutput] = useState('');
  const [input, setInput] = useState('');

  useEffect(() => {
    startGame();
  }, []);

  const startGame = async () => {
    try {
      const response = await fetch('http://localhost:3001/start', {
        method: 'POST',
      });
      const data = await response.json();
      setOutput(data.output);
    } catch (error) {
      console.error('Error starting the game:', error);
    }
  };

  const checkInput = async () => {
    try {
      const response = await fetch('http://localhost:3001/check', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ input }),
      });
      const data = await response.json();
      setOutput(data.output);
    } catch (error) {
      console.error('Error checking input:', error);
    }
  };

  return (
    <div className="App">
      <h1>Memory Game</h1>
      <p>{output}</p>
      <input
        type="text"
        value={input}
        onChange={(e) => setInput(e.target.value)}
        placeholder="Enter the sequence"
      />
      <button onClick={checkInput}>Submit</button>
    </div>
  );
}

export default App;
